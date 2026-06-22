import { describe, it, expect } from 'vitest';
import {
  isValidCedula,
  sanitizeSearchTerm,
  isValidRUC,
  isValidPanamaPhone,
  isValidEmail,
  generateId,
} from '../validation';

describe('isValidCedula', () => {
  it('validates regular cedula', () => {
    expect(isValidCedula('8-123-4567')).toBe(true);
  });

  it('validates double-digit province', () => {
    expect(isValidCedula('10-456-7890')).toBe(true);
  });

  it('validates Panama Este prefix', () => {
    expect(isValidCedula('PE-12-3456')).toBe(true);
  });

  it('validates Extranjero prefix', () => {
    expect(isValidCedula('E-12-34567')).toBe(true);
  });

  it('validates Naturalizado prefix', () => {
    expect(isValidCedula('N-12-34567')).toBe(true);
  });

  it('validates other letter prefixes', () => {
    expect(isValidCedula('AV-12-34567')).toBe(true);
  });

  it('rejects invalid format', () => {
    expect(isValidCedula('invalid')).toBe(false);
  });

  it('rejects empty string', () => {
    expect(isValidCedula('')).toBe(false);
  });

  it('rejects null', () => {
    expect(isValidCedula(null)).toBe(false);
  });
});

describe('isValidRUC', () => {
  it('validates correct RUC', () => {
    expect(isValidRUC('155737034-2-2023')).toBe(true);
  });

  it('validates short RUC', () => {
    expect(isValidRUC('1-2-3')).toBe(true);
  });

  it('rejects invalid format', () => {
    expect(isValidRUC('invalid')).toBe(false);
  });

  it('rejects empty', () => {
    expect(isValidRUC('')).toBe(false);
  });

  it('rejects null', () => {
    expect(isValidRUC(null)).toBe(false);
  });
});

describe('isValidPanamaPhone', () => {
  it('validates number starting with 6', () => {
    expect(isValidPanamaPhone('62345678')).toBe(true);
  });

  it('validates number starting with 5', () => {
    expect(isValidPanamaPhone('52345678')).toBe(true);
  });

  it('strips non-digit characters', () => {
    expect(isValidPanamaPhone('6234-5678')).toBe(true);
  });

  it('rejects number starting with 1', () => {
    expect(isValidPanamaPhone('12345678')).toBe(false);
  });

  it('rejects 7-digit number', () => {
    expect(isValidPanamaPhone('6234567')).toBe(false);
  });

  it('rejects 9-digit number', () => {
    expect(isValidPanamaPhone('623456789')).toBe(false);
  });

  it('rejects null', () => {
    expect(isValidPanamaPhone(null)).toBe(false);
  });

  it('rejects empty', () => {
    expect(isValidPanamaPhone('')).toBe(false);
  });
});

describe('isValidEmail', () => {
  it('validates standard email', () => {
    expect(isValidEmail('test@example.com')).toBe(true);
  });

  it('validates email with subdomain', () => {
    expect(isValidEmail('user@mail.example.com')).toBe(true);
  });

  it('rejects missing @', () => {
    expect(isValidEmail('testexample.com')).toBe(false);
  });

  it('rejects missing domain', () => {
    expect(isValidEmail('test@')).toBe(false);
  });

  it('rejects null', () => {
    expect(isValidEmail(null)).toBe(false);
  });

  it('rejects empty', () => {
    expect(isValidEmail('')).toBe(false);
  });
});

describe('generateId', () => {
  it('uses default prefix', () => {
    expect(generateId()).toMatch(/^id-/);
  });

  it('uses custom prefix', () => {
    expect(generateId('ord')).toMatch(/^ord-/);
  });

  it('generates unique IDs', () => {
    const id1 = generateId();
    const id2 = generateId();
    expect(id1).not.toBe(id2);
  });
});

describe('sanitizeSearchTerm', () => {
  it('strips PostgREST/URL filter metacharacters (injection)', () => {
    expect(sanitizeSearchTerm('a,b)(c*:&%=#"\\')).toBe('abc');
    expect(sanitizeSearchTerm('order_number.eq.1),customer_name')).toBe('ordernumbereq1customername');
  });
  it('keeps letters (incl. accents), digits, spaces and hyphens', () => {
    expect(sanitizeSearchTerm('  José Pérez-3  ')).toBe('José Pérez-3');
    expect(sanitizeSearchTerm('1234')).toBe('1234');
  });
  it('handles empty/nullish', () => {
    expect(sanitizeSearchTerm('')).toBe('');
    expect(sanitizeSearchTerm(null)).toBe('');
    expect(sanitizeSearchTerm(undefined)).toBe('');
  });
});
