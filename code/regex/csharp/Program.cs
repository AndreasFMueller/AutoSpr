using System;
using System.Text;
using System.Text.RegularExpressions;

namespace csharp
{
    public static class Program
    {
	    private const int N = 29;

	    public static void Main(string[] args)
        {
	        if (args.Length != 1 || !bool.TryParse(args[0], out var useCompiled))
	        {
		        Console.WriteLine("Verwendung: dotnet run [false|true]");
		        return;
	        }
	        
	        Console.WriteLine(useCompiled ? "Match mit 'Compiled' flag:" : "Match ohne Optionen:");
	        
	        var regexOptions = useCompiled ? RegexOptions.Compiled : RegexOptions.None;
	        var	s1 = string.Empty;
	        var	s2 = string.Empty;
	        // baue einen Präfix-String fuer die "schöne" Einrückung
	        // der Resultate
	        var prefix = string.Empty;
	        for (var i = 0; i < N; i++) {
		        prefix += " ";
	        }

	        // führe den Test durch fuer Stringlängen von 1 bis N
	        for (var i = 1; i <= N; i++) {
		        // Stringkomponenten verlaengern
		        s1 += "a";
		        s2 += "a?";
		        var	r = s2 + s1;
		        Console.Write(prefix.Substring(i));
		        Console.Write(s1);
		        Console.Write(Regex.IsMatch(s1, r, regexOptions) ? " matches " : " doesn't match ");
		        Console.WriteLine(r);
	        }
        }
    }
}
