// Generated by CoffeeScript 1.6.1
(function() {
  var _this = this,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  YakShave.BigYakView = (function(_super) {

    __extends(BigYakView, _super);

    function BigYakView() {
      var _this = this;
      this.updateTimer = function() {
        return BigYakView.prototype.updateTimer.apply(_this, arguments);
      };
      this.shaveIt = function() {
        return BigYakView.prototype.shaveIt.apply(_this, arguments);
      };
      return BigYakView.__super__.constructor.apply(this, arguments);
    }

    BigYakView.prototype.template = '#big_yak-template';

    BigYakView.prototype.events = {
      "click .shave": "onShaveClick"
    };

    BigYakView.prototype.onShaveClick = function(e) {
      var target;
      target = $(e.target);
      if (target.hasClass('small')) {
        $('#yak').addClass('small');
        return this.shave(6);
      } else if (target.hasClass('medium')) {
        $('#yak').addClass('medium');
        return this.shave(20);
      } else if (target.hasClass('large')) {
        $('#yak').addClass('large');
        return this.shave(120);
      }
    };

    BigYakView.prototype.shave = function(minutes) {
      $('#yak').show();
      this.totalDuration = minutes * 60;
      this.startTime = new Date();
      this.strokeDuration = this.totalDuration / 6;
      this.x = 16;
      this.dX = 9;
      $('.shave').hide();
      this.shaveIt();
      this.updateTimer();
      this.timerInterval = setInterval(this.updateTimer, 1000);
      return this.shaveInterval = setInterval(this.shaveIt, this.strokeDuration * 1000);
    };

    BigYakView.prototype.shaveIt = function() {
      var razor,
        fur,
        _this = this;
      razor = $('#razor');
      fur = $('#fur');
      this.x += this.dX;

      razor.css({
        top: '15%',
        right: ((this.x - 12) / .75) + "%",
        "-webkit-transition": "top 0s linear, right 0s linear"
      });
      razor.hide().show(0);

      fur.css({
        '-webkit-transition': '-webkit-mask-position-y 0s linear',
        'webkit-mask-position': this.x + "% 100%"
      })
      fur.hide().show(0);

      setTimeout(function() {
        razor.css({
          top: '65%',
          "-webkit-transition": "top " + _this.strokeDuration + "s linear, right " + _this.strokeDuration + "s linear"
        });
        fur.css('-webkit-transition', "-webkit-mask-position-y " + _this.strokeDuration + "s linear");
        return fur.css('webkit-mask-position', _this.x + "% 50%");
      }, 0);
      if (this.x + this.dX >= 79) {
        return clearInterval(this.shaveInterval);
      }
    };

    BigYakView.prototype.updateTimer = function() {
      var elapsedSeconds, minutesLeft, remainingSeconds, secondsLeft, zero;
      elapsedSeconds = (new Date() - this.startTime) / 1000;
      remainingSeconds = this.totalDuration - elapsedSeconds;
      minutesLeft = Math.floor(remainingSeconds / 60);
      secondsLeft = Math.floor(remainingSeconds % 60);
      zero = secondsLeft < 10 ? "0" : "";
      $('#timer').html("" + minutesLeft + ":" + zero + secondsLeft + " left!");
      if (remainingSeconds <= 0) {
        clearInterval(this.timerInterval);
        return $('#timer').html("Done!<br>Now back to work!");
      }
    };

    return BigYakView;

  })(Marionette.ItemView);

}).call(this);
