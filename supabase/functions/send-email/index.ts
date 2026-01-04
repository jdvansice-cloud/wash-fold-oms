// Supabase Edge Function: send-email
// Deploy with: supabase functions deploy send-email
//
// This function sends emails using the SMTP configuration stored in the companies table

import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
import { SMTPClient } from "https://deno.land/x/denomailer@1.6.0/mod.ts";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

interface EmailRequest {
  to: string;
  subject: string;
  html: string;
  text?: string;
  company_id: string;
}

serve(async (req) => {
  // Handle CORS preflight
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const supabaseKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
    const supabase = createClient(supabaseUrl, supabaseKey);

    const { to, subject, html, text, company_id }: EmailRequest = await req.json();

    // Get SMTP settings from database
    const { data: company, error: companyError } = await supabase
      .from("companies")
      .select("smtp_host, smtp_port, smtp_user, smtp_pass, smtp_from_name, smtp_from_email, smtp_secure, name")
      .eq("id", company_id)
      .single();

    if (companyError || !company) {
      throw new Error("Company not found or SMTP not configured");
    }

    if (!company.smtp_host || !company.smtp_user || !company.smtp_pass) {
      throw new Error("SMTP configuration incomplete");
    }

    // Create SMTP client
    const client = new SMTPClient({
      connection: {
        hostname: company.smtp_host,
        port: company.smtp_port || 587,
        tls: company.smtp_secure !== false,
        auth: {
          username: company.smtp_user,
          password: company.smtp_pass,
        },
      },
    });

    // Send email
    await client.send({
      from: {
        address: company.smtp_from_email || company.smtp_user,
        name: company.smtp_from_name || company.name || "Notification",
      },
      to: [{ address: to }],
      subject: subject,
      content: text || "",
      html: html,
    });

    await client.close();

    return new Response(
      JSON.stringify({ success: true, message: "Email sent successfully" }),
      {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 200,
      }
    );
  } catch (error) {
    console.error("Error sending email:", error);
    return new Response(
      JSON.stringify({ success: false, error: error.message }),
      {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 500,
      }
    );
  }
});
