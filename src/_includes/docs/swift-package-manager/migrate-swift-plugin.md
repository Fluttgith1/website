Replace `plugin_name` throughout this guide with the name of your plugin.
The example below uses `ios`, replace `ios` with `macos`/`darwin` as applicable.

1. [Enable the Swift Package Manager feature][enableSPM].

2. Start by creating a directory under the `ios`, `macos`, and/or `darwin`
   directories.
   Name this new directory the name of the platform package.

   <pre>
   plugin_name/ios/
   ├── ...
   └── <b>plugin_name/</b>
   </pre>

3. Within this new directory, create the following files/directories:

    - `Package.swift` (file)
    - `Sources` (directory)
    - `Sources/plugin_name` (directory)

   Your plugin should look like:

   <pre>
   plugin_name/ios/
   ├── ...
   └── plugin_name/
      ├── <b>Package.swift</b>
      └── <b>Sources/plugin_name/</b>
   </pre>

4. Use the following template in the `Package.swift` file:

   ```swift title="Package.swift"
   // swift-tools-version: 5.9
   // The swift-tools-version declares the minimum version of Swift required to build this package.
   
   import PackageDescription
   
   let package = Package(
       name: "plugin_name",
       platforms: [
           // The platforms your plugin supports.
           // If your plugin only supports iOS, remove `.macOS(...)`.
           // If your plugin only supports macOS, remove `.iOS(...)`.
           .iOS("12.0"),
           .macOS("10.14")
       ],
       products: [
           // If the plugin name contains "_", replace with "-" for the library name
           .library(name: "plugin-name", targets: ["plugin_name"])
       ],
       dependencies: [],
       targets: [
           .target(
               name: "plugin_name",
               dependencies: [],
               resources: [
                   // If your plugin requires a privacy manifest, for example if it uses
                   // any required reason APIs, update the PrivacyInfo.xcprivacy file to
                   // describe your plugin's privacy impact, and then uncomment these lines.
                   // For more information, see:
                   // https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
                   // .process("PrivacyInfo.xcprivacy"),
   
                   // If you have other resources that need to be bundled with your plugin, refer to
                   // the following instructions to add them:
                   // https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package
               ]
           )
       ]
   )
   ```

   :::note
   If the plugin name contains `_`, the library name must be a `-` separated
   version of the plugin name.
   :::

5. If your plugin has a [`PrivacyInfo.xcprivacy` file][], move it to
   `ios/Sources/plugin_name/PrivacyInfo.xcprivacy` and uncomment the resource in
   the `Package.swift` file.

   ```swift title="Package.swift"
               resources: [
                   // If your plugin requires a privacy manifest, for example if it uses
                   // any required reason APIs, update the PrivacyInfo.xcprivacy file to
                   // describe your plugin's privacy impact, and then uncomment these lines.
                   // For more information, see:
                   // https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
                   [!.process("PrivacyInfo.xcprivacy"),!]
   
                   // If you have other resources that need to be bundled with your plugin, refer to
                   // the following instructions to add them:
                   // https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package
               ],
   ```

6. Move any resource files from `ios/Assets` to `ios/Sources/plugin_name`
   (or a subdirectory).
   Add the resource files to your `Package.swift` file, if applicable.
   For more instructions, see
   [https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package](https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package).

7. Move all files from `ios/Classes` to `ios/Sources/plugin_name`.

8. The `ios/Assets`, `ios/Resources`, and `ios/Classes` directories should now
   be empty and can be deleted.

9. If your plugin uses [Pigeon][], update your Pigeon input file.

   ```diff2html
   --- a/pigeons/messages.dart
   +++ b/pigeons/messages.dart
   @@ -16,7 +16,7 @@ import 'package:pigeon/pigeon.dart';
      kotlinOptions: KotlinOptions(),
      javaOut: 'android/app/src/main/java/io/flutter/plugins/Messages.java',
      javaOptions: JavaOptions(),
   -  swiftOut: 'ios/Classes/messages.g.swift',
   +  swiftOut: 'ios/plugin_name/Sources/plugin_name/messages.g.swift',
      swiftOptions: SwiftOptions(),
   ```

10. Update your `Package.swift` file with any customizations you might need.

    1. Open the `ios/plugin_name/` directory in Xcode.

       :::tip
       If Xcode does not show any files, quit Xcode (**Xcode > Quit Xcode**) and
       reopen.

       If Xcode isn't updating after you make a change, try clicking
       **File > Packages > Reset Package Caches**.
       :::

    2. In Xcode, open your `Package.swift` file.
       Verify Xcode does not produce any warnings or errors for this file.

    3. If your `ios/plugin_name.podspec` file has [CocoaPods `dependency`][]s,
       add the corresponding [Swift Package Manager dependencies][] to your
       `Package.swift` file.

    4. If your package must be linked explicitly `static` or `dynamic`
       ([not recommended by Apple][]), update the [Product][] to define the
       type:

       ```swift title="Package.swift"
       products: [
           .library(name: "plugin-name", type: .static, targets: ["plugin_name"])
       ],
       ```

    5. Make any other customizations. For more information on how to write a
       `Package.swift` file, see
       [https://developer.apple.com/documentation/packagedescription](https://developer.apple.com/documentation/packagedescription).

       :::tip
       If you add additional targets to your `Package.swift` file,
       try to name them uniquely.
       If your target name conflicts with another target from another package,
       this can cause issues for developers that use your plugin.
       :::

11. Update your `ios/plugin_name.podspec` to point to new paths.

    ```diff2html
    --- a/ios/plugin_name.podspec
    +++ b/ios/plugin_name.podspec
    @@ -1,2 +1,2 @@ 
    - s.source_files = 'Classes/**/*.swift'
    - s.resource_bundles = {'plugin_name_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
    + s.source_files = 'plugin_name/Sources/plugin_name/**/*.swift'
    + s.resource_bundles = {'plugin_name_privacy' => ['plugin_name/Sources/plugin_name/PrivacyInfo.xcprivacy']}
    ```

12. Update loading of resources from bundle to use [`Bundle.module`][].

    ```swift
    #if SWIFT_PACKAGE
         let settingsURL = Bundle.module.url(forResource: "image", withExtension: "jpg")
    #else
         let settingsURL = Bundle(for: Self.self).url(forResource: "image", withExtension: "jpg")
    #endif
    ```

    :::note
    `Bundle.module` only works if there are resources
    [defined in the `Package.swift` file][Bundling resources] or
    [automatically included by Xcode][Xcode resource detection]).
    Otherwise, using `Bundle.module` results in an error.
    :::

13. Verify the plugin still works with CocoaPods.

    1. Disable Swift Package Manager.

    ```sh
    flutter config --no-enable-swift-package-manager
    ```

    2. Run `flutter run` with the example app and ensure it builds and runs.

    3. Run CocoaPods validation lints.

    ```sh
    pod lib lint ios/plugin_name.podspec  --configuration=Debug --skip-tests --use-modular-headers --use-libraries
    ```

    ```sh
    pod lib lint ios/plugin_name.podspec  --configuration=Debug --skip-tests --use-modular-headers
    ```

14. Verify the plugin works with Swift Package Manager.

    1. Enable Swift Package Manager.

    ```sh
    flutter config --enable-swift-package-manager
    ```

    2. Run `flutter run` with the example app and ensure it builds and runs.

    3. Open the example app in Xcode and ensure that **Package Dependencies**
       shows in the left **Project Navigator**.

15. Verify tests pass.

  * **If your plugin has native unit tests (XCTest), make sure you also
    [update unit tests in the plugin's example app][].**

  * Follow instructions for [testing plugins][].

[enableSPM]: /packages-and-plugins/swift-package-manager/for-plugin-authors#how-to-enable-swift-package-manager
[`PrivacyInfo.xcprivacy` file]: https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
[Pigeon]: https://pub.dev/packages/pigeon
[CocoaPods `dependency`]: https://guides.cocoapods.org/syntax/podspec.html#dependency
[Swift Package Manager dependencies]: https://developer.apple.com/documentation/packagedescription/package/dependency
[not recommended by Apple]: https://developer.apple.com/documentation/packagedescription/product/library(name:type:targets:)
[Product]: https://developer.apple.com/documentation/packagedescription/product
[`Bundle.module`]: https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package#Access-a-resource-in-code
[Bundling resources]: https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package#Explicitly-declare-or-exclude-resources
[Xcode resource detection]: https://developer.apple.com/documentation/xcode/bundling-resources-with-a-swift-package#:~:text=Xcode%20detects%20common%20resource%20types%20for%20Apple%20platforms%20and%20treats%20them%20as%20a%20resource%20automatically
[update unit tests in the plugin's example app]: /packages-and-plugins/swift-package-manager/for-plugin-authors/#how-to-update-unit-tests-in-a-plugins-example-app
[testing plugins]: https://docs.flutter.dev/testing/testing-plugins
