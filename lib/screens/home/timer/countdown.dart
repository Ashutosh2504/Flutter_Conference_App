class CountDown {
  String timeLeft(
    DateTime due,
    String finishedText,
    String daysTextLong,
    String hoursTextLong,
    String minutesTextLong,
    String secondsTextLong,
    String daysTextShort,
    String hoursTextShort,
    String minutesTextShort,
    String secondsTextShort, {
    bool? longDateName,
    bool? showLabel,
    bool collapsing = false,
    String endingText = ' left',
  }) {
    String retVal = "";

    Duration _timeUntilDue = due.difference(DateTime.now());

    if (_timeUntilDue.inSeconds < 0) {
      return finishedText;
    }

    int _daysUntil = _timeUntilDue.inDays;
    int _hoursUntil = _timeUntilDue.inHours - (_daysUntil * 24);
    int _minUntil =
        _timeUntilDue.inMinutes - (_daysUntil * 24 * 60) - (_hoursUntil * 60);
    int _secUntil = _timeUntilDue.inSeconds -
        (_daysUntil * 24 * 3600) -
        (_hoursUntil * 3600) -
        (_minUntil * 60);

    // Check whether to return longDateName date name or not
    if (showLabel == false) {
      if (_daysUntil > 0) {
        retVal += _daysUntil.toString() + " : ";
      }
      if (_hoursUntil > 0 || _daysUntil > 0) {
        // Display hours if they are non-zero or if there are days
        retVal += _hoursUntil.toString() + " : ";
      }
      if (_minUntil > 0 || _hoursUntil > 0 || _daysUntil > 0) {
        // Display minutes if they are non-zero or if there are hours or days
        retVal += _minUntil.toString() + " : ";
      }
      retVal += _secUntil.toString();
    } else {
      if (longDateName == false) {
        if (_daysUntil > 0) {
          retVal += _daysUntil.toString() + daysTextShort;
        }
        if ((_hoursUntil > 0 || _daysUntil > 0) &&
            (!collapsing || _daysUntil <= 0)) {
          retVal += _hoursUntil.toString() + hoursTextShort;
        }
        if ((_minUntil > 0 || _hoursUntil > 0 || _daysUntil > 0) &&
            (!collapsing || _hoursUntil <= 0)) {
          retVal += _minUntil.toString() + minutesTextShort;
        }
        if ((_secUntil > 0 ||
                _minUntil > 0 ||
                _hoursUntil > 0 ||
                _daysUntil > 0) &&
            (!collapsing || _minUntil <= 0)) {
          retVal += _secUntil.toString() + secondsTextShort;
        }
      } else {
        if (_daysUntil > 0) {
          retVal += _daysUntil.toString() + daysTextLong;
        }
        if ((_hoursUntil > 0 || _daysUntil > 0) &&
            (!collapsing || _daysUntil <= 0)) {
          retVal += _hoursUntil.toString() + hoursTextLong;
        }
        if ((_minUntil > 0 || _hoursUntil > 0 || _daysUntil > 0) &&
            (!collapsing || _hoursUntil <= 0)) {
          retVal += _minUntil.toString() + minutesTextLong;
        }
        if ((_secUntil > 0 ||
                _minUntil > 0 ||
                _hoursUntil > 0 ||
                _daysUntil > 0) &&
            (!collapsing || _minUntil <= 0)) {
          retVal += _secUntil.toString() + secondsTextLong;
        }
      }
    }

    if (collapsing) {
      retVal += endingText;
    }

    return retVal;
  }
}
