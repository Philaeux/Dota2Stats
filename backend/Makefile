install:
	python3 -m venv .venv
	.venv/bin/pip3 install --upgrade pip
	.venv/bin/pip3 install -r requirements.txt
	make path-install

path-install:
	$(foreach dir, $(wildcard .venv/lib/python3.*), echo $(shell pwd)/api > $(dir)/site-packages/dota2stats.pth &&) echo

run:
	.venv/bin/python3 api/dota2stats.py

clean:
	rm -rf .venv
