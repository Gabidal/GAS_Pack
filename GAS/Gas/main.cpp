 #include <fstream>
 using namespace std;
 
 
char buffer[4096];
char paranthesis[256];
char secondParanthesis[256];
char line[256];
char math[128];
 
 void openFile()
 {
	ifstream file("main.g");
	
	if (file.good())
	 {
		 file.read(buffer, 4096);
	 }
	 file.close();
 }
 
void getByte(char* destination,char* source, char wanted)
 {
	 for (int i = 0; i < 256;i++)
	 {
		 if (source[i] != wanted) 
		 {
			 destination[i] = source[i];
		 }
		 else 
		 {
			 return 0;
		 }
	 }
 }
 
 int main()
{
	openFile();
	getByte(line, buffer, ";");
	getByte(paranthesis, line, ")");
	getByte(secondParanthesis, paranthesis, "(");
	if (getByte(math, secondParanthesis, "*") == 0 );
	{
		
		
	}
	else
	{
		
		
		
	}
	 return 0;
 }
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 