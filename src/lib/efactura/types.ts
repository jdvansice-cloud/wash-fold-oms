// TypeScript types for the efacturapty PAC `InvoiceRequest` payload.
//
// These mirror the request DTOs in the PAC OpenAPI spec
// (https://api.efacturapty.com/swagger/v1/swagger.json). Only the fields the
// builder actually emits are typed; the PAC auto-fills emisor data and assigns
// the document number, so those are intentionally omitted.

/** Receptor (buyer) identification block. */
export interface RucReceptor {
  /** 1 = persona natural, 2 = persona jurídica. */
  tipoContribuyente: number;
  rucReceptor: string;
  digitoVerificador: string;
}

export interface UbicacionReceptor {
  /** DGI location code "provincia-distrito-corregimiento" (e.g. "8-8-7"). */
  codigoUbicacion?: string;
  corregimiento?: string;
  distrito?: string;
  provincia?: string;
}

export interface IdentificacionExtranjera {
  pasaportNumeroIdentificacionExtranjera: string;
  paisExtranjero?: string;
}

export interface InformacionReceptor {
  /** RECEPTOR_TYPE: 01 contribuyente, 02 consumidor final, 03 gobierno, 04 extranjero. */
  tipoReceptorFe: string;
  datosRucReceptor?: RucReceptor;
  nombreRazonReceptor?: string;
  direccionReceptor?: string;
  ubicacionReceptor?: UbicacionReceptor;
  grupoIdentificacionExtranjera?: IdentificacionExtranjera;
  correoElectronicoReceptor?: string;
  paisReceptor: string;
}

export interface DatosGenerales {
  tipoEmision: string;
  tipoDocumento: string;
  /** Omitted on emission — the PAC assigns it. Present only when echoed back. */
  numeroDocumento?: number;
  puntoFacturacion: string;
  /** ISO 8601 with Panama offset, e.g. "2026-06-21T14:05:05-05:00". */
  fechaEmision: string;
  naturalezaOperacion: string;
  tipoOperacion: number;
  destinoOperacion: number;
  formatoGeneracionCafe: number;
  maneraEntregaCafe: number;
  envioContenedorReceptor: number;
  procesoGeneracionFe: number;
  informacionReceptor: InformacionReceptor;
}

export interface GrupoPrecios {
  precioUnitarioTransferencia: number;
  /** Per-unit discount. Present only when the line is discounted. */
  descuento?: number;
  /** Net line price (unitario × cantidad − descuento × cantidad), pre-ITBMS. */
  precioItem: number;
  precioAcarreo?: number;
  /** precioItem + montoITBMS (+ acarreo). */
  sumaPrecioItem: number;
}

export interface GrupoItbmsItem {
  /** TASA_ITBMS: 00 exento, 01 7%, 02 10%, 03 15%. */
  tasaITBMSAplicable: string;
  montoITBMS: number;
}

export interface ListaItem {
  numeroSecuenciaItem: number;
  descripcionProductoServicio: string;
  codigoInternoItem?: string;
  cantidadProductoServicio: number;
  codigoItemCodificacionPanamenaAbreviada?: number;
  codigoItemCodificacionPanamena?: number;
  grupoPrecios: GrupoPrecios;
  grupoITBMS: GrupoItbmsItem;
}

export interface FormaPago {
  /** PAYMENT_FORMA codes: 01 crédito, 02 efectivo, 03 tarjeta crédito, … 99 otro. */
  formaPago: string;
  formaPagoDescripcion?: string;
  valorCuotaPagada: number;
}

export interface DescuentoBonificacion {
  descripcionDescuentoBonificacion: string;
  montoDescuentoBonificacion: number;
}

export interface Totales {
  totalNeto: number;
  totalITBMS?: number;
  totalGravado?: number;
  totalDescuento?: number;
  totalAcarreo?: number;
  valorTotalFactura: number;
  sumaValoresRecibidos: number;
  vueltoEntregado?: number;
  tiempoPago: number;
  numeroTotalItems: number;
  totalTodosItems: number;
  grupoFormasPago?: FormaPago[];
  grupoDescuentosBonificaciones?: DescuentoBonificacion[];
}

export interface InvoiceRequest {
  datosGenerales: DatosGenerales;
  listaItems: ListaItem[];
  totales: Totales;
}
