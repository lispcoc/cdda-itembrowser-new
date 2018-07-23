Cataclysm DDA Item/Recipe Browser
=================================

This is a simple tool to browse through the items and recipes available in [Cataclysm: Dark Days Ahead](http://en.cataclysmdda.com), this is done by reading the game's data files and creating an optimized database linking everything together.

The original codebase (referencing 0.C stable and early 0.C experimental/trunk) is currently hosted by Sergio Duran (Sheco) at [http://cdda.estilofusion.com](http://cdda.estilofusion.com)

This branch has been updated to support the latest changes in the game JSON (0.C experimental) and is currently hosted by Chezzo (Chesthole) at [http://cdda-trunk.chezzo.com](http://cdda-trunk.chezzo.com)

### Features

- Search for items and monsters.
- Show how an item can be crafted.
- Show recipes using each item.
- Automatic item catalogs, clothing, melee, ranged weapons, consumables, books, materials, qualities, flags, skills and gun mods.
- Monster catalogs.

### Installation

Additional scripts were created to support running as a manually installed app on a shared hosting site. Some host specific references were applied in order to use the correct PHP binary.

(Original instructions below for reference.)

============================================

This can be used in a [Vagrant](https://www.vagrantup.com/) environment. The current scripts provided have been tested on the official ubuntu/trusty32 vagrant box.

On windows, you will need an appropiate rsync.exe and ssh.exe on the path, (msys gets the job done). rsync was used instead of the default shared folders, because the shared folders are very slow.

To setup and run the environment, execute:

```
vagrant up
```

Everything should be up and running in a few minutes, you should be able to access the webapp at the appropiate address, it will probably be http://localhost:8000

### Manual instalation

If you don't want to run a vagrant setup, you only need to make sure you
have the appropiate dependencies.

* composer
* php5.4 (with the mcrypt extension)
* memcached
* A webserver

Then you can run the setup.sh script, which will download the game's source
code and composer dependencies.

The webserver should be able to read and write the files in the "storage"
directory inside the data file path.

### Contributing

Please read the [hacking guide](HACKING.md) to get an idea about how to read
the code so you can update it. 

You should then follow regular github guidelines to clone, commit and create pull requests.

### License

This application is open-sourced software licensed under the [MIT license](LICENSE.txt)
