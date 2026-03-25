import { describe, it, expect } from 'vitest';
import {
  formatCurrency,
  formatDate,
  formatTime,
  formatRelativeTime,
  formatPhone,
  formatWeight,
  formatPercentage,
  formatOrderNumber,
  truncateText,
  getInitials,
  getInitialsFromParts,
  hoursUntil,
  isOverdue,
} from '@/utils/formatters';

describe('formatCurrency', () => {
  it('formats a number with two decimals', () => {
    expect(formatCurrency(12.5)).toBe('B/12.50');
  });

  it('formats zero', () => {
    expect(formatCurrency(0)).toBe('B/0.00');
  });

  it('formats large numbers', () => {
    expect(formatCurrency(1234.56)).toBe('B/1234.56');
  });

  it('handles NaN', () => {
    expect(formatCurrency(NaN)).toBe('B/0.00');
  });

  it('handles null', () => {
    expect(formatCurrency(null)).toBe('B/0.00');
  });

  it('handles undefined', () => {
    expect(formatCurrency(undefined)).toBe('B/0.00');
  });
});

describe('formatDate', () => {
  it('formats a date string', () => {
    const result = formatDate('2024-03-15T12:00:00Z');
    expect(result).toBeTruthy();
    expect(typeof result).toBe('string');
  });

  it('returns empty string for null', () => {
    expect(formatDate(null)).toBe('');
  });

  it('returns empty string for undefined', () => {
    expect(formatDate(undefined)).toBe('');
  });

  it('returns empty string for invalid date', () => {
    expect(formatDate('invalid')).toBe('');
  });
});

describe('formatPhone', () => {
  it('formats 8-digit Panama number with dashes', () => {
    expect(formatPhone('+507', '62345678')).toBe('+507 6234-5678');
  });

  it('uses default country code when null', () => {
    expect(formatPhone(null, '62345678')).toBe('+507 6234-5678');
  });

  it('returns empty for null phone', () => {
    expect(formatPhone('+507', null)).toBe('');
  });

  it('handles non-8-digit numbers', () => {
    expect(formatPhone('+1', '1234567890')).toBe('+1 1234567890');
  });
});

describe('formatWeight', () => {
  it('formats weight in kg', () => {
    expect(formatWeight(3.5)).toBe('3.50 kg');
  });

  it('handles zero', () => {
    expect(formatWeight(0)).toBe('0.00 kg');
  });

  it('handles NaN', () => {
    expect(formatWeight(NaN)).toBe('0.00 kg');
  });

  it('handles null', () => {
    expect(formatWeight(null)).toBe('0.00 kg');
  });
});

describe('formatPercentage', () => {
  it('formats whole number', () => {
    expect(formatPercentage(7, 0)).toBe('7%');
  });

  it('formats with decimals', () => {
    expect(formatPercentage(7.5, 1)).toBe('7.5%');
  });

  it('handles NaN', () => {
    expect(formatPercentage(NaN)).toBe('0%');
  });
});

describe('formatOrderNumber', () => {
  it('prepends hash', () => {
    expect(formatOrderNumber(157)).toBe('#157');
  });

  it('works with string', () => {
    expect(formatOrderNumber('CC1234')).toBe('#CC1234');
  });
});

describe('truncateText', () => {
  it('truncates long text', () => {
    expect(truncateText('Hello World', 5)).toBe('Hello...');
  });

  it('returns short text as-is', () => {
    expect(truncateText('Hi', 5)).toBe('Hi');
  });

  it('handles null', () => {
    expect(truncateText(null)).toBe('');
  });
});

describe('getInitials', () => {
  it('extracts initials from full name', () => {
    expect(getInitials('Juan VanSice')).toBe('JV');
  });

  it('handles single name', () => {
    expect(getInitials('Maria')).toBe('M');
  });

  it('handles null', () => {
    expect(getInitials(null)).toBe('?');
  });

  it('limits to 2 characters', () => {
    expect(getInitials('A B C D')).toBe('AB');
  });
});

describe('getInitialsFromParts', () => {
  it('extracts from first and last', () => {
    expect(getInitialsFromParts('Maria', 'Gonzalez')).toBe('MG');
  });

  it('handles missing last name', () => {
    expect(getInitialsFromParts('Maria', null)).toBe('M');
  });

  it('handles both null', () => {
    expect(getInitialsFromParts(null, null)).toBe('?');
  });
});

describe('hoursUntil', () => {
  it('returns positive for future date', () => {
    const future = new Date();
    future.setHours(future.getHours() + 5);
    const result = hoursUntil(future.toISOString());
    expect(result).toBeGreaterThan(4);
    expect(result).toBeLessThan(6);
  });

  it('returns negative for past date', () => {
    const past = new Date();
    past.setHours(past.getHours() - 3);
    const result = hoursUntil(past.toISOString());
    expect(result).toBeLessThan(0);
  });

  it('returns null for null input', () => {
    expect(hoursUntil(null)).toBeNull();
  });
});

describe('isOverdue', () => {
  it('returns true for past date', () => {
    expect(isOverdue('2020-01-01')).toBe(true);
  });

  it('returns false for future date', () => {
    const future = new Date();
    future.setFullYear(future.getFullYear() + 1);
    expect(isOverdue(future.toISOString())).toBe(false);
  });

  it('returns false for null', () => {
    expect(isOverdue(null)).toBe(false);
  });
});
