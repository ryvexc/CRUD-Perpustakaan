import "dart:io";

dynamic input(String message) {
	stdout.write(message);
	return stdin.readLineSync();
}

bool getYesOrNo(String message) {
	stdout.write(message);
	if(stdin.readLineSync() == "y") return true;
	else return false;
}

int getHighestLenghtFromArrayString(List<String> arr) {
	int height = 0;
	for(int i=0; i<arr.length; i++) {
		if(height < arr[i].length) height = arr[i].length;
	}
	return height;
}
