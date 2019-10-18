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




.PHONY: logger
logger: bin/python
	bin/flask run --host=0.0.0.0















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

ESP8266_BIN:=esp8266-20190529-v1.11.bin
.PHONY: micropython
micropython: esp8266-20190529-v1.11.bin
esp8266-20190529-v1.11.bin:
	wget http://micropython.org/resources/firmware/${ESP8266_BIN}

# You have to set it,
PORT:=/dev/ttyUSB9
.PHONY: flash
flash: micropython
	bin/esptool.py --before default_reset --after hard_reset --baud 115200 --chip esp8266 --port ${PORT} write_flash --flash_mode=dout --flash_size=detect --verify 0x0 ${BIN}

.PHONY: sonoff_flash
sonoff_flash: micropython
	bin/esptool.py --port ${PORT} write_flash -fs 1MB -fm dout 0x0 ${BIN}


.PHONY: erase
erase:
	bin/esptool.py --port ${PORT} erase_flash

homeassistant_config:
	mkdir -p ${@}

.PHONY: hass
hass: homeassistant_config
	${BIN}/hass -c homeassistant_config

