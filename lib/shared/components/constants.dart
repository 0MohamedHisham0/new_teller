// category = business entertainment general health science sports technology

String getCategoryFromText(String text) {
  print(text);
  if (text.contains('business')) {
    return 'business';
  }
  if (text.contains('entertainment')) {
    return 'entertainment';
  }
  if (text.contains('general')) {
    return 'general';
  }
  if (text.contains('health')) {
    return 'health';
  }
  if (text.contains('science')) {
    return 'science';
  }
  if (text.contains('sports')) {
    return 'sports';
  }
  if (text.contains('technology')) {
    return 'technology';
  }
  return '';
}
