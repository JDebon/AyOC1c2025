AS := nasm
ASFLAGS := -f elf64 -F DWARF -g -Wall
LD := ld
LDFLAGS := -g
TARGET ?= HolaMundo

.PHONY: all clean
all: $(TARGET)
# assembly
$(TARGET).o: $(TARGET).asm
	$(AS) $(ASFLAGS) $<

# linking
$(TARGET): $(TARGET).o
	$(LD) $(LDFLAGS) $< -o $@
	@rm -f $(TARGET).o
	@./$(TARGET)
	@rm -f $(TARGET)

clean:
	rm -rf *.o $(TARGET)