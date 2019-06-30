#include <fstream>
#include <string>
#include <vector>
using namespace std;

const char Operators[] = { '*', '/', '+', '-' };
const char* Opcodes[] = { "type", "num", "if", "else", "for", };
const AsmOp AsmLib[] = { AsmLib.Op = "mov", AsmLib.Op = "add", AsmLib.Op = "sub", AsmLib.Op = "inc", AsmLib.Op = "dec",AsmLib.Op = "eax", AsmLib.Op = "ebx", AsmLib.Op = "ecx", AsmLib.Op = "edx", AsmLib.Op = "esi",AsmLib.Op = "edi", AsmLib.Op = "ebp", AsmLib.Op = "esp", AsmLib.Op = "ax", AsmLib.Op = "bx", AsmLib.Op = "cx", AsmLib.Op = "dx", AsmLib.Op = "si",AsmLib.Op = "di", AsmLib.Op = "bp", AsmLib.Op = "sp", AsmLib.Op = "xchg", AsmLib.Op = "section", AsmLib.Op = ".code", AsmLib.Op = ".text",
AsmLib.Op = ".data",AsmLib.Op = ".bss",AsmLib.Op = "db",AsmLib.Op = "dw",AsmLib.Op = "dd",AsmLib.Op = ",",AsmLib.Op = "\n"}

class AsmOp
{
public:
	string Op = "mov ax, ax"

}

class Variable
{
	public:
		Location location;
};

enum LocationType
{
	Register,
	Stack
};

class Location
{
public:
	LocationType Type;
};

class RegisterLocation : public Location
{
};


int mu()
{
	Location location;

	if (location.Type == Register)
	{
		RegisterLocation& reg = *static_cast<RegisterLocation*>(&location);
	}
	else
	{
		StackLocation& stack = *static_cast<StackLocation*>(&location);
	}
}

class StackLocation : public Location
{

};

vector<Variable> Variables;

string variables[1024] = " "  //kaikki tyhjyys on väli lyönti


class Token
{
public:

	string Text;

	// Tää vois viitata sen arvoon
	void* Data;

	int number;
	Operator Operator;
	Token* Next;
	Token* Previous;

};



class Operator : public Token
{

};

vector<Token> Chop()
{

}

void Process(string& section)
{
	string paranthesis;

	if (GetParanthesis(section, paranthesis))
	{
		Process(paranthesis);
	}

	
}

bool GetParanthesis(string& section, string& out)
{
	int s = section.find('(');
	int e = section.find_first_of(')');

	if (s == -1 || e == -1)
	{
		return false;
	}

	out = section.substr(s, e - s);
	return true;
}

int GetVariable (string& name, string& variables )
{
	while (true)
	{
		int i = variables.length();
		if(name == variables[i])
		{
			return i;                 //return var offset
		}
		else
		{
	       i++                       //if not found this roud get next word from variables
		}
	}
}

int main()
{
	ifstream file("C:\\Users\\X\\Downloads\\main.g");
	vector<string> lines;

	if (file.good())
	{
		while (file.good())
		{
			char buffer[4096];
			file.getline(buffer, 4096);

			string line(buffer);

			lines.push_back(move(line));
		}
	}

	file.close();

	for (string& line : lines)
	{
		Process(line);
	}

	return 0;	
}

