# Variabel untuk Assembler dan Linker
AS = nasm
ASFLAGS = -f elf32
LD = ld
LDFLAGS = -m elf_i386

# Nama file executable
TARGET = monitor

# Daftar file objek
OBJS = monitor.o cpu.o memory.o proc.o times.o print_num.o

# Rule utama (default)
all: $(TARGET)

# Cara membuat executable 'monitor'
$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) -o $(TARGET) $(OBJS)

# Rule untuk masing-masing file objek
monitor.o: monitor.asm headers.inc
	$(AS) $(ASFLAGS) monitor.asm -o monitor.o

cpu.o: cpu.asm headers.inc
	$(AS) $(ASFLAGS) cpu.asm -o cpu.o

memory.o: memory.asm headers.inc
	$(AS) $(ASFLAGS) memory.asm -o memory.o

proc.o: proc.asm headers.inc
	$(AS) $(ASFLAGS) proc.asm -o proc.o

times.o: times.asm headers.inc
	$(AS) $(ASFLAGS) times.asm -o times.o

print_num.o: print_num.asm
	$(AS) $(ASFLAGS) print_num.asm -o print_num.o

# Rule untuk membersihkan file sampah
clean:
	rm -f *.o $(TARGET)

# Rule untuk menjalankan program
run: all
	./$(TARGET)
