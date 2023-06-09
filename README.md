<a href="https://www.buymeacoffee.com/st1vms"><img src="https://img.buymeacoffee.com/button-api/?text=1 Pizza Margherita&emoji=🍕&slug=st1vms&button_colour=0fa913&font_colour=ffffff&font_family=Bree&outline_colour=ffffff&coffee_colour=FFDD00" /></a>
# Linux Task Helper v0.1.0

## Configuration file

Tasks are added into a JSON configuration file,
named

**`tasks_config.json`**

this file must be created manually, in the **/etc** folder. Changes made to the file will be reflected only when the service/script is restarted.

The configuration file has this format:
```json
{
    "tasks": [
        {
            "workDir": "/path/to/working/dir",
            "cmd": "command to execute",
            "runsOn": []
        },
        {
            "workDir": "/path/to/working/dir",
            "cmd": "another command to execute",
            "runsOn": [
                "00:00:00",
                "14:00:00"
            ]
        }
    ]
}
```

### Where:
- **workDir** is the working directory on where to run the command

- **cmd** is the command to run

- **runsOn** is a list storing 24h formatted clock strings
"**HH:MM:SS**", if this list is empty, the command will be runned on service start. Otherwise it will schedule command execution based on these times.

### An easy way to edit the configuration file is to use nano:
```bash
sudo nano /etc/tasks_config.json
```
-----

## Installation

Either download the zip and extract the source folder, or run

```bash
git clone https://github.com/st1vms/linux-task-helper
```

*cd* into the source folder and run:
```bash
chmod u+x ./install.sh
```

run the installation script using:
```bash
./install.sh
```
*NOTE: you don't have to run these commands as sudo, but sudo password will be asked in any case as it's required for a few tasks.*

---

### After installing and creating a configuration file,
### enable the systemd service using:
```bash
systemctl enable linux-task-helper.service
```

### and start it using:
```bash
systemctl start linux-task-helper.service
```


### To view scheduler's output

```bash
systemctl status linux-task-helper.service
```


### Uninstallation
```bash
chmod u+x ./uninstall.sh && ./uninstall.sh
```
