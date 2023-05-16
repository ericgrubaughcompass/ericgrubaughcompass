import record from 'N/record';
import Record from 'N/record/instance';

jest.mock('N/record');
jest.mock('N/record/instance');

beforeEach(() => {
  jest.clearAllMocks();
});

describe('Basic jest test with simple assert', () => {
  it('should assert strings are equal', () => {
    const a = 'foobar';
    const b = 'foobar';
    expect(a).toMatch(b);
  });
});
