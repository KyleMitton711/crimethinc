# Adding a language

A runbook for translating https://crimethinc.com into another language

## For everyone

### Language code

Everyone reading this will need to know that language code for language you're working on.

1. Determine the 2-letter language code for the language you are adding
    - `xx`
    - https://www.iana.org/assignments/language-subtag-registry/language-subtag-registry
    - For example, `pt` for Portuguese

## For translators

### Updating an existing translation

1. Find the language file in this folder https://github.com/crimethinc/website/tree/main//config/locales
    - The file will have a name in the format of `[xx].yml`
    - For example, `pt.yml` for Portuguese

1. Edit this file to add your translations (more on YAML file formatting below)

1. Send the updated file to the code collective
    - If you know how to use git / GitHub, you can make a pull reqest
    - If not, that's ok! You can email them to the code collective instead (see the _Emailing the CrimethInc. Code Collective_ section below)

### Creating a new translation

1. Double check for the language file in this folder https://github.com/crimethinc/website/tree/main//config/locales
    - The file will have a name in the format of `[xx].yml`
    - For example, `pt.yml` for Portuguese
    - If it exists, follow the steps in the _Updating an existing translation_ section above
    - If it doesn't exist already, continue to the next step

1. Download the English language file
    - `en.yml`
    - For easier viewing: https://github.com/crimethinc/website/blob/main//config/locales/en.yml
    - For downloading: https://raw.githubusercontent.com/crimethinc/website/main//config/locales/en.yml
    - Either save the file from your browser to your computer, or copy all of the text on that webpage and then paste it into a text editor on your computer

1. Name your new file using the two letter language code, with a `.yml` file extension
    - Example, `pt.yml` for Portuguese

1. First things first, change the root key from `en:` to your language code
    - Example: For Portuguese, change `en:` to `pt:`

1. Then, translate only the values (see the _Working with YAML files_ section below)
    - Please, don't translate or change any of the keys

1. Send the updated file to the code collective
    - If you know how to use git / GitHub, you can make a pull reqest
    - If not, that's ok! You can email them to the code collective instead (see the _Emailing the CrimethInc. Code Collective_ section below)

### Working with YAML files

1. This format is called YAML.
    - The left side of the colon is called a "key", the right side is that key's "value".
    - Indentation matters. Please don't change the spacing at the start of any lines.

1. Edit this file in a plain text editor ([Atom](https://atom.io), [VS Code](https://code.visualstudio.com), [TextMate](https://macromates.com), [Sublime](https://www.sublimetext.com), [Notepad](https://en.wikipedia.org/wiki/Microsoft_Notepad), etc).
    - Please do NOT edit this file in a word processor ([Pages](https://www.apple.com/pages), [MS Word](https://products.office.com/word), [MS Works](https://en.wikipedia.org/wiki/Microsoft_Works), [Open Office](https://en.wikipedia.org/wiki/OpenOffice.org), [Libre Office](https://en.wikipedia.org/wiki/LibreOffice), etc).

1. Then, translate only the values (see the _Working with YAML files_ section below)
    - Please, don't translate or change any of the keys

1. A `#` character starts a comment, which will only be read by humans, not computers.
    - You can leave notes to yourself or others as comments. (Example: `## meta_title is wrapped in…`)

1. Please retain any formatting syntax characters that are in the YAML.
    - If a value has **Markdown** syntax characters in it, please keep those in your translation.
    - Markdown examples: `[link text](url)`, `**bold**`, `_italics_`, `%{dynamic variable}`, etc.
    - If a value has **HTML** syntax characters in it, please keep those in your translation.
    - HTML examples: `<b>bold</b>`, `<a href='http://example.com'>Link text</a>`, etc.

### Emailing the CrimethInc. Code Collective

1. Send those files to the code collective at [tech@crimethinc.com](mailto:tech@crimethinc.com)
    - If PGP/GPG is imporant to you, email them to [crimethinc.ex.workers.collective@protonmail.com](mailto:crimethinc.ex.workers.collective@protonmail.com)
    - Our public key can be found at https://crimethinc.com/key.pub

***
***
***

## For code collective

### DNS concerns

1. Add the domain to the Heroku app
    - `heroku domains:add [2-letter language code].crimethinc.com`
    - For example, `heroku domains:add pt.crimethinc.com`

1. Copy the HerokuDNS.com URL provided in the output of that command for the `CNAME` record

1. Add the subdomain to DNS host with a `CNAME` record matching the `HerokuDNS.com` URL from the previous step

### Files

TODO

### Locales Service

TODO
