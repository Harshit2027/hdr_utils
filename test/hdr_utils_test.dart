import 'package:flutter_test/flutter_test.dart';
import 'package:hdr_utils/hdr_utils.dart';

void main() {
  group('ValidatorUtils Tests', () {
    test('validateFullName test', () {
      expect(ValidatorUtils.validateFullName(''), 'Full name cannot be empty.');
      expect(
        ValidatorUtils.validateFullName('A'),
        'Full name must be between 2 and 30 characters.',
      );
      expect(ValidatorUtils.validateFullName('Harshit Rajput'), isNull);
    });

    test('validateEmailAddress test', () {
      expect(
        ValidatorUtils.validateEmailAddress(''),
        'Email address cannot be empty.',
      );
      expect(
        ValidatorUtils.validateEmailAddress('invalid-email'),
        'Please enter a valid email address.',
      );
      expect(ValidatorUtils.validateEmailAddress('test@example.com'), isNull);
    });
  });

  group('Extensions Tests', () {
    test('String Capitalization', () {
      expect('hello'.capitalize, 'Hello');
      expect(''.capitalize, '');
      expect('a'.capitalize, 'a');
    });

    test('Email Obscuring', () {
      expect('harshit@gmail.com'.obscureEmail(), 'har****@gmail.com');
      expect('abc@test.com'.obscureEmail(), 'abc@test.com');
    });

    test('Number Formatting', () {
      expect(1250.compactFormat, '1.3K');
      expect(1000000.compactFormat, '1M');
    });
  });
}
