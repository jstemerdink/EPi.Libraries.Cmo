   /// <reference path="jQuery/jquery-1.3.2-vsdoc.js" />
(function ($) {
    $.widget("ui.passwordInput", {
        _init: function () {
            var self = this, o = this.options;

            if (this.element.val() == '' && o.noPassword) {
                return;
            }
            this.element.hide();

            var wrapper = $("<span />");
            wrapper.attr('class', this.element.attr('class'));
            wrapper.addClass('ui-passwordInput');

            var passwordSpan = $("<span />");
            passwordSpan.text('*******');

            var passwordChangeButton = $("<input type='button' />");
            passwordChangeButton.val(o.changeButtonText);
            passwordChangeButton.click(function (e) {
                wrapper.hide();
                self.element.show();
                self.element.focus();
            });

            wrapper.append(passwordSpan);
            wrapper.append(passwordChangeButton);
            this.element.after(wrapper);
        }

    });

    $.extend($.ui.passwordInput, {
        defaults: {
            changeButtonText: 'Change password',
            noPassword: true
        }
    });


})(jQuery);
