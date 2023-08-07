import subprocess

commands = ["flutter clean",
            "flutter pub get",
            "flutter pub run flutter_launcher_icons",
            "flutter build apk"
            ]

for command in commands:
    print(f"Running: {command}")
    proc = subprocess.run(command, stdout=subprocess.PIPE,
                      stderr=subprocess.PIPE, shell=True, text=True)
    print(proc.stdout)
    print(proc.stderr)