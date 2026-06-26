# latihan1

A new Flutter project.

### Run the app

```
flutter run --flavor development --dart-define-from-file=.env.dev.json
```

### Generate file

```
dart run build_runner build --delete-conflicting-outputs
```

### generate flavor

```
flutter pub run flutter_flavorizr -p assets:download,assets:extract,android:androidManifest,android:flavorizrGradle,android:buildGradle,android:dummyAssets,android:icons,flutter:flavors,ios:podfile,ios:xcconfig,ios:buildTargets,ios:schema,ios:dummyAssets,ios:icons,ios:plist,ios:launchScreen,google:firebase,assets:clean
```