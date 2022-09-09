using FireSharp.Config;
using FireSharp.Interfaces;
using FireSharp.Response;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SaveWordListToFirebase
{
    internal class WordModel
    {
        public string Word { get; set; }
    }
    internal class Program
    {
        static void Main(string[] args)
        {
            IFirebaseConfig fbconfig = new FirebaseConfig
            {
                //Your Project's AuthSecret Key.
                AuthSecret = "",
                //Your Realtime Database Link.
                BasePath = ""
            };
            IFirebaseClient fbclient;

            fbclient = new FireSharp.FirebaseClient(fbconfig);
            if (fbclient != null)
            {
                Console.WriteLine("Connection is completed.");
            }
            else
            {
                Console.WriteLine("Connection failed.");
                Environment.Exit(1);
            }

            Console.WriteLine("The 'Words' table will be deleted and then recreated. Do you confirm? (Y / N)");
            string choice = Console.ReadLine();

            if (choice == "y" || choice == "Y")
            {
                fbclient.Delete("Words");
                Console.WriteLine("The 'Words' table has been deleted. Press any key to continue...");
                Console.ReadLine();

                Console.WriteLine("\nPlease do not close the window until the process is finished...");

                string filepath = @"english_word_4974.txt";
                List<string> lines = File.ReadAllLines(filepath).ToList();
                
                for (int i = 0; i < lines.Count; i++)
                {
                    WordModel word = new WordModel() { Word = lines[i] };

                    fbclient.Set("Words/" + i, word);
                }
            }
            else
            {
                Environment.Exit(2);
            }


            Console.WriteLine("\r\nProcess completed.");
            Console.ReadLine();
        }
    }
}
