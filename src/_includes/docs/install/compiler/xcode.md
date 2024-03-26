## Configure iOS development

{% assign prompt1='$' %}
{% assign devos = include.devos %}
{% assign target = include.target %}
{% assign attempt = include.attempt %}

### Configure Xcode

{% if attempt=="first" %}

To develop Flutter apps for {{target}}, install Xcode to compile to native bytecode.

1. To configure the command-line tools to use the installed version of Xcode,
   run the following commands.

    ```console
    {{prompt1}} sudo sh -c 'xcode-select -s /Applications/Xcode.app/Contents/Developer && xcodebuild -runFirstLaunch'
    ```

   To use the latest version of Xcode, use this path.
   If you need to use a different version, specify that path instead.

1. Sign the Xcode license agreement.

    ```console
    {{prompt1}} sudo xcodebuild -license
    ```

{% else %}

This section presumes you have installed and configured Xcode when you
installed Flutter for

{%- case target %}
{%- when 'iOS' %}
[macOS desktop][macos-install]
{%- when 'desktop' %}
[iOS][ios-install]
{%- endcase %}
 development.

[macos-install]: /get-started/install/macos/desktop/#configure-ios-development
[ios-install]: /get-started/install/macos/mobile-ios/#configure-ios-development

{% endif %}

Try to keep to the current version of Xcode.

{% if target=='iOS' %}

### Configure your target iOS device

With Xcode, you can run Flutter apps on an iOS device or on the simulator.

{% comment %} Nav tabs {% endcomment -%}
<ul class="nav nav-tabs" id="ios-devices-vp" role="tablist">
    <li class="nav-item">
        <a class="nav-link active" id="virtual-tab" href="#virtual" role="tab" aria-controls="virtual" aria-selected="true">Virtual Device</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" id="physical-tab" href="#physical" role="tab" aria-controls="physical" aria-selected="false">Physical Device</a>
    </li>
</ul>

{% comment %} Tab panes {% endcomment -%}
<div class="tab-content">

<div class="tab-pane active" id="virtual" role="tabpanel" aria-labelledby="virtual-tab">

{% include docs/install/devices/ios-simulator.md %}

</div>

<div class="tab-pane" id="physical" role="tabpanel" aria-labelledby="physical-tab">

{% include docs/install/devices/ios-physical.md %}

</div>
</div>
{% comment %} End: Tab panes. {% endcomment -%}

{% endif %}

{% if attempt=="first" %}

### Install CocoaPods

If your apps depend on [Flutter plugins][] with native {{target}} code,
install [CocoaPods][cocoapods].
This program bundles various dependencies across Flutter and {{target}} code.

To install and set up CocoaPods, run the following commands:

1. Install `cocoapods` following the
   [CocoaPods install guide][cocoapods].

   ```console
   $ sudo gem install cocoapods
   ```
1. Launch your preferred text editor.

1. Open the Zsh environmental variable file `~/.zshenv` in your text editor.

1. Copy the following line and paste it at the end of your `~/.zshenv` file.

   ```conf
   export PATH=$HOME/.gem/bin:$PATH
   ```

1. Save your `~/.zshenv` file.

1. To apply this change, restart all open terminal sessions.

[Flutter plugins]: /packages-and-plugins/developing-packages#types

{% endif %}

[cocoapods]: https://guides.cocoapods.org/using/getting-started.html#installation
