VENV:=virtual_env
BIN=${VENV}/bin
PYTHON=${BIN}/python3
PIP=${BIN}/pip

${PYTHON}:
	git submodule update --init
	python3 -mvenv ${VENV}
	${PIP} install --upgrade wheel setuptools pip
	${PIP} install -r requirements.txt

.PHONY: clean
clean:
	git clean -xfd

.PHONY: venv
venv: ${PYTHON}


.PHONY: test
test:
	${BIN}/pytest


.PHONY: jupyter
jupyter:
	${BIN}/jupyter-notebook












### Hardware.
uPyLoader-linux:
	curl -L -o ${@} https://github.com/BetaRavener/uPyLoader/releases/download/v0.1.4/uPyLoader-linux
	chmod +x ${@}
	
.PHONY: uPyLoader
uPyLoader: uPyLoader-linux
	./${^}
	
webrepl/webrepl.html:
	git submodule update --init
	
.PHONY: webrepl
webrepl: webrepl/webrepl.html
	firefox ${^}

ESP32_BIN:=esp32-20191011-v1.11-422-g98c2eabaf.bin
.PHONY: micropython
micropython: ${ESP32_BIN}
${ESP32_BIN}:
	wget http://micropython.org/resources/firmware/${ESP8266_BIN}

# You have to set it,
PORT:=/dev/ttyUSB9
.PHONY: flash
flash: micropython
	${BIN}/esptool.py --before default_reset --after hard_reset --baud 115200 --chip esp32 --port ${PORT} write_flash --flash_mode=dout --flash_size=detect --verify 0x0 ${ESP32_BIN}

.PHONY: sonoff_flash
sonoff_flash: micropython
	bin/esptool.py --port ${PORT} write_flash -fs 1MB -fm dout 0x0 ${ESP32_BIN}


.PHONY: erase
erase:
	bin/esptool.py --port ${PORT} erase_flash

homeassistant_config:
	mkdir -p ${@}

.PHONY: hass
hass: homeassistant_config
	${BIN}/hass -c homeassistant_config

