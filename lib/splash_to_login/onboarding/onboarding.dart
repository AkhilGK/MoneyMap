class Onboarding {
  String imagepathOB;
  String titleOB;
  String subtitleOB;
  Onboarding(
      {required this.imagepathOB,
      required this.titleOB,
      required this.subtitleOB});
}
//

List<Onboarding> oBlist = [
  Onboarding(
      imagepathOB: 'Assets/images/OBimg1.png',
      titleOB: 'Better Financial\nManagement',
      subtitleOB: "Easy to know  your transactions "),
  Onboarding(
      imagepathOB: 'Assets/images/OBimg2.png',
      titleOB: 'Safe and\nSecure',
      subtitleOB: "Privacy is important "),
  Onboarding(
      imagepathOB: 'Assets/images/OBimg3.png',
      titleOB: 'Better Saving\nOption',
      subtitleOB: "Know the expences and spend wise"),
];
