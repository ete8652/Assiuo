require("UIColor");

defineClass("FirstViewController", {
            viewDidLoad: function() {
            self.super().viewDidLoad();
            self.view().setBackgroundColor(UIColor.yellowColor());
            self.creatView();
            }
            }, {});
