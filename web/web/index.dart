import 'package:vue/vue.dart';

import 'package:web/my_component.dart';

@VueApp(el: '#app', components: [MyComponent])
class App extends VueAppBase {
}

App app;

void main() {
  app = App();
  app.create();
}
