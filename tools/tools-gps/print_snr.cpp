#include <iostream>
#include <iomanip>
#include <fstream>
#include <sstream>
#include <set>

using namespace std;

// gcc /view/tools/print_snr.cpp -lstdc++ -o /usr/local/bin/print_snr.exe;
// tac /data/r105/msn105_131.sys | print_snr

/***************************************************************************
*
* CLASS: SnrString
*
* DESCRIPTION:
*
*   This class represents SNR as string of data.
*
***************************************************************************/
class SnrString
{
    /***********************************************************************
    * attributes
    ***********************************************************************/
    public:

        const string snr_string;

    /***********************************************************************
    * construction methods
    ***********************************************************************/
    public:

        /***************************************************************
        * constructor
        ***************************************************************/

            SnrString(const string& snr_string)
            :
                snr_string(snr_string)
            {}

        /***************************************************************
        * assignment operator
        ***************************************************************/

            void
            operator = (const SnrString& other)
            {
                const_cast<string&>(this->snr_string) = other.snr_string;
            }

        /***************************************************************
        * copy constructor
        ***************************************************************/

            SnrString(const SnrString& other)
            {
                *this = other;
            }

    /***********************************************************************
    * methods
    ***********************************************************************/
    public:

        /***************************************************************
        * text representing this object
        ***************************************************************/

            const string text(void) const
            {
                ostringstream line; line.fill(' '); line.str("");
                {
                    line << this->snr_string;
                }
                return line.str();
            }
           
        /***************************************************************
        * operator equals
        ***************************************************************/

            bool
            operator == (const SnrString& other) const
            {
                return
                (
                    this->snr_string.substr(0,9).compare(
                    other.snr_string.substr(0,9)) == 0
                );
            }
                        
        /***************************************************************
        * operator less than
        ***************************************************************/

            bool
            operator < (const SnrString& other) const
            {
                return
                (
                    this->snr_string.substr(0,9).compare(
                    other.snr_string.substr(0,9)) < 0
                );
            }
};


/***************************************************************************
* local namespace
***************************************************************************/
namespace
{
    set<SnrString> allSnrs;
}

/***************************************************************************
* filter cin to cout
***************************************************************************/
int main(void)
{
    if (false)
    {
        // Create the input file stream
        ifstream rin("offline.in", ios::in);

        // Create the output file stream
        ofstream rout("offline.out", ios::out|ios::trunc);

        rin.close();
        rout.close();
    }

    // initial print
    cout << endl;

    // Read lines
    char buf[1000];
    while (not cin.getline(buf, 999).eof())
    {
        string line(buf);
        if (line.find("Snr:") != string::npos)
        {
            line.assign(line, 38, string::npos);
            ::allSnrs.insert(line);
        }
    }

   set<SnrString>::const_iterator iter = allSnrs.begin();
   while (iter != allSnrs.end())
   {
       cout << iter->snr_string << endl;
       if (iter->snr_string.find("L2C") != string::npos) cout << endl;
       iter++;
   }

    // Read tokens separated by white space
    string token;
    while (false and cin >> token)
    {
        cout << token << endl;
    }

    exit(0);
}
