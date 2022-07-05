import "package:dart_console/dart_console.dart";
import "dart:io";
import "package:crud_dart/helper_fun.dart";

final console = Console();

// END FUNCTION HELPER

void mainMenu() {
	List<String> menus = ["Lihat buku", "Edit Buku", "Tambah buku", "Hapus buku"];
	int i=0;
	for(i=0; i<menus.length; i++) {
		print((i+1).toString() + ". " + menus[i]);
	}
	print((i+1).toString() + ". Keluar");
}

void showBuku() {
	console.clearScreen();
	File file = new File("data.txt");
	List<String> buku = file.readAsLinesSync();
	int highestFileName = 9, highestPenerbit = 8;
	for(String book in buku) {
		if(book.split(",")[0].length > highestFileName) highestFileName = book.split(",")[0].length;
		if(book.split(",")[1].length > highestPenerbit) highestPenerbit = book.split(",")[1].length;
	}

	for(int space=0; space<7+highestFileName+3+highestPenerbit+3+buku[0].split(",")[2].length+2; space++) stdout.write("-"); print("");
	stdout.write("| No | Nama Buku"); for(int i=0; i<highestFileName - 9; i++) stdout.write(" ");
	stdout.write(" | Penerbit"); for(int i=0; i<highestPenerbit - 8; i++) stdout.write(" ");
	stdout.write(" | Tanggal    |\n");
	for(int space=0; space<7+highestFileName+3+highestPenerbit+3+buku[0].split(",")[2].length+2; space++) stdout.write("-"); print("");
	for(int i=0; i<buku.length; i++) {
		stdout.write("| " + (i+1).toString() + ((i+1).toString().length == 1 ? "  " : " ") + "| " + buku[i].split(",")[0]);
		for(int x=0; x<=highestFileName - buku[i].split(",")[0].length; x++) stdout.write(" ");
		stdout.write("| " + buku[i].split(",")[1]);
		for(int x=0; x<=highestPenerbit - buku[i].split(",")[1].length; x++) stdout.write(" ");
		stdout.write("| " + buku[i].split(",")[2] + " | \n");
	}
	for(int space=0; space<7+highestFileName+3+highestPenerbit+3+buku[0].split(",")[2].length+2; space++) stdout.write("-"); print("");
}

void editBuku() {
	while(true) {
		console.clearScreen();
		File data_buku = new File("data.txt");
		List<String> buku = data_buku.readAsLinesSync();
		showBuku();
		if(!getYesOrNo("Apakah anda ingin mengedit buku? [y/n]: ")) break;
		stdout.write("masukkan nomor buku yang akan di edit: ");
		int bukuYangAkanDiEdit = int.parse(stdin.readLineSync().toString());
		if(bukuYangAkanDiEdit >= buku.length) {
			print("Buku yang anda masukkan tidak tersedia.");
			continue;
		}
		print("\nMasukkkan data buku yang baru");
		String nama_buku = input("Nama buku: ").toString();
		String nama_penerbit = input("Nama penerbit: ").toString();
		String tanggal_buku = input("Tanggal penerbitan (dd-mm-yyyy): ").toString();
		String formatted_str = "$nama_buku,$nama_penerbit,$tanggal_buku";
		if(getYesOrNo("\nApakah anda yakin ingin merubah? [y/n]: ")) {
			buku[bukuYangAkanDiEdit - 1] = formatted_str;
			data_buku.writeAsStringSync(buku.join("\n"));
			if(buku[bukuYangAkanDiEdit - 1] == formatted_str) print("Buku berhasil diedit");
			else print("[ERROR] Buku gagal diedit.");
		}
		else print("Membatalkan.");
	}
}

void tambahBuku() {
	while(true) {
		console.clearScreen();
		showBuku();
		File data = new File("data.txt");
		List<String> buku_tersedia = data.readAsLinesSync();
		String formatted_str = "";
		for(String buku in buku_tersedia) {
			formatted_str += (buku + "\n");
		}

		if(!getYesOrNo("Apakah anda ingin menambahkan buku? [y/n]: ")) break;
		print("\nMasukkan data buku");
		String namabuku = input("Nama buku: ").toString();
		String penerbit = input("Penerbit: ").toString();
		String tanggal = input("Tanggal penerbitan: (dd-mm-yy): ").toString();
		String fmt = "$namabuku,$penerbit,$tanggal";
		if(getYesOrNo("\nApakah anda yakin ingin menambahkan buku tsb? [y/n]: ")) {
			data.writeAsStringSync(formatted_str + fmt);
			print("buku berhasil ditambahkan");
		}
	}
}

void hapusBuku() {
	while(true) {
		console.clearScreen();
		File data = new File("data.txt");
		List<String> buku = data.readAsLinesSync();
		showBuku();
		if(!getYesOrNo("Apakah anda ingin menghapus buku? [y/n]: ")) break;
		stdout.write("Masukkan nomor buku yang akan di hapus: ");
		int bukuYangAkanDihapus = int.parse(stdin.readLineSync().toString());
		String formatted_str = "";
		for(int i=0; i<buku.length; i++) {
			if(i != bukuYangAkanDihapus - 1) formatted_str += (buku[i] + "\n");
		}
		print("\nPilihan anda");
		print(buku[bukuYangAkanDihapus - 1]);
		if(getYesOrNo("\nApakah kamu yakin akan menghapus buku ini? [y/n]: ")) {
			data.writeAsStringSync(formatted_str);
			print("[STATUS] buku berhasil dihapus");
		} else {
			print("Membatalkan.");
		}
	}
}

void main(List<String> args) {
	while(true) {
		console.clearScreen();
		print("Ryve Perpustakaan\n");
		mainMenu();
		int inp = int.parse(input("\n> "));
		if(inp == 1) {
			while(true) {
				showBuku();
				if(getYesOrNo("masukkan 'y' untuk kembali: ")) break;
			}
		}
		else if(inp == 2) editBuku();
		else if(inp == 3) tambahBuku();
		else if(inp == 4) hapusBuku();
		else if(inp == 5) exit(0);
		else print("Input tidak ada");
	}
}
