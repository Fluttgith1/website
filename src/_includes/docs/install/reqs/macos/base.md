{% assign target = include.target %}
{% assign os = include.os %}

## System requirements

To install and run Flutter,
your {{os}} environment must meet these requirements:

### Hardware requirements

Your {{os}} Flutter development environment must meet the following
minimal hardware requirements.

<div class="table-wrapper" markdown="1">
|     Requirement              |                                    Minimum                               |    Recommended      |
|:-----------------------------|:------------------------------------------------------------------------:|:-------------------:|
| x86_64 CPU Cores             | 4                                                                        | 8                   |
| Memory in GB                 | 8                                                                        | 16                  |
| Display resolution in pixels | WXGA (1366 x 768)                                                        | FHD (1920 x 1080)   |
| Free disk space in GB        | {% include docs/install/reqs/macos/storage.md target=target %}
</div>

### Software requirements

To write and compile Flutter code for {{target}},
you must have the following version of macOS and the listed
software packages.

#### Operating system
{:.no_toc}

Flutter supports {{site.devmin.macOS}} or later.

#### Development tools
{:.no_toc}

Download and install the macOS version of the following packages:

{% include docs/install/reqs/macos/software.md target=target %}

The developers of the preceding software provide support for those products.
To troubleshoot installation issues, consult that product's documentation.

#### Text editor or integrated development environment
{:.no_toc}

You can build apps with Flutter using any text editor or
integrated development environment (IDE) combined with
Flutter’s command-line tools.

Using an IDE with a Flutter extension or plugin provides code completion,
syntax highlighting, widget editing assists, debugging, and other features.

Popular options include:

* [Android Studio][] {{site.appmin.android_studio}} or later
  with the [Flutter plugin for IntelliJ][].
* [IntelliJ IDEA][] {{site.appmin.intellij_idea}} or later
  with the [Flutter plugin for IntelliJ][].
* [Visual Studio Code][] {{site.appmin.vscode}} or later
  with the [Flutter extension for VS Code][].

{{site.alert.recommend}}
  The Flutter team recommends installing
  [Visual Studio Code][] {{site.appmin.vscode}} or later and the
  [Flutter extension for VS Code][].
  This combination simplifies installing the Flutter SDK.
{{site.alert.end}}

[Android Studio]: https://developer.android.com/studio/install
[IntelliJ IDEA]: https://www.jetbrains.com/help/idea/installation-guide.html
[Visual Studio Code]: https://code.visualstudio.com/docs/setup/mac
[Flutter extension for VS Code]: https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter
[Flutter plugin for IntelliJ]: https://plugins.jetbrains.com/plugin/9212-flutter
