require("UIColor");

defineClass("ViewController", {
            viewDidLoad: function() {
            self.super().viewDidLoad();
            self.view().setBackgroundColor(UIColor.yellowColor());
            self.creatView();
            }
            }, {});
