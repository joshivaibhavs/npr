# npm run with tab completion for bash

### Usage

1. Copy the file `npr_autocomplete.sh` in your home (`~`) directory.
2. Source it in your `.bashrc` file: `source ~/npr_autocomplete.sh`
3. When in a node project, run `npr <tab> <tab>` and it will read the `scripts` section of your `package.json` file and try to autocomplete from the scripts.
4. Works as tab completion is expected (it will complete the command after typing the first letter, etc.)
5. After the command is tab-completed, hit enter and it will execute `npm run <your-command>`.

### Prerequisites

Your system need to have `bash`, `compgen`, `complete` and `node` already installed on your system.

### Contributions welcome. Feel free to open an issue/create a PR.
