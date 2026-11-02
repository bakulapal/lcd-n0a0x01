KDIR ?= /lib/modules/$(shell uname -r)/build
MODULE := lcd-n0a0x01
MODULE_DIR := /lib/modules/$(shell uname -r)/extra
MODULES_LOAD := /etc/modules-load.d/lcd.conf

.PHONY: default clean install

default:
	@if [ ! -d "$(KDIR)" ]; then \
		echo "ERROR: Kernel headers not found: $(KDIR)"; \
		echo "Install them with: sudo apt install linux-headers-$(shell uname -r)"; \
		exit 1; \
	fi
	$(MAKE) -C $(KDIR) M=$(CURDIR) modules

clean:
	$(MAKE) -C $(KDIR) M=$(CURDIR) clean

install: default
	install -D -m 644 $(MODULE).ko $(MODULE_DIR)/$(MODULE).ko
	depmod -a
	printf '%s\n' '$(MODULE)' > $(MODULES_LOAD)
	modprobe $(MODULE)
