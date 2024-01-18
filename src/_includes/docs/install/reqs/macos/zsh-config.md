{% assign target = include.target %}

<details markdown="1">
<summary><strong>To verify your shell configuration, expand this section</strong></summary>

Like most UNIX-like operating system, macOS can support multiple shells,
like `bash`, `zsh`, and `sh`.

As of the October 2019 release of macOS Catalina (macOS 10.15),
Zsh or `zsh` is the default shell for macOS.

#### Check and set `zsh` as default
{:.no_toc}

1. To verify `zsh` has been installed and set as
   the default macOS shell, run the following commands.

    ```terminal
    $ which zsh; dscl . -read ~/ UserShell
    ```

    {{terminal}} should print the following as its response.

    ```terminal
    /bin/zsh
    UserShell: /bin/zsh
    ```

1. If you need to install `zsh`, run the following command.

    ```terminal
    $ brew install zsh
    ```

   To check if your install succeeded,
   run the command in the previous step after installing `zsh`.

1. If you need to change your default shell to `zsh`, run the following command.

    ```terminal
    $ chsh -s `which zsh`
    ```


To learn more about macOS and `zsh`, check out
[Use zsh as the default shell on your Mac][zsh-mac] in the macOS
documentation.

</details>
