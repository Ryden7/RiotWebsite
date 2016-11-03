using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//a
public partial class _Default : System.Web.UI.Page
{
    private static string ChampDB;
    RitoLibrary.RitoAPI asdf = new RitoLibrary.RitoAPI();
   

    protected void Button1_Click(object sender, EventArgs e)
    {

        /*
        RiotApi.Net.RestClient.RiotClient riotClient = new RiotApi.Net.RestClient.RiotClient("c3878111-a85e-4618-86fc-c142e0bea549");

        RiotApi.Net.RestClient.Dto.LolStaticData.Champion.ChampionListDto ChampDto;
        ChampDto = riotClient.LolStaticData.GetChampionList(RiotApi.Net.RestClient.Configuration.RiotApiConfig.Regions.NA, null, null, null, null);
        List<String> Champlist = new List<String>();

        foreach (var entry in ChampDto.Data)
        {
            Champlist.Add(entry.Key);
        }

        for (int i = 0; i < 130; i++)
        {
            test(Champlist[i]);

        }
        */

        
        Response.Redirect("Webpages/Data/Champdata.aspx?Champname=" + txtContactsSearch.Text + "&Sumname=" + TextBox1.Text);

    }

    public void test(String champ)
    {
        ChampDB = ConfigurationManager.ConnectionStrings["asdf"].ConnectionString;

        /*
        RiotApi.Net.RestClient.RiotClient riotClient = new RiotApi.Net.RestClient.RiotClient("c3878111-a85e-4618-86fc-c142e0bea549");

        RiotApi.Net.RestClient.Dto.LolStaticData.Champion.ChampionListDto ChampDto;
        ChampDto = riotClient.LolStaticData.GetChampionList(RiotApi.Net.RestClient.Configuration.RiotApiConfig.Regions.NA, null, null, null, null);
        List<String> Champlist = new List<String>();

        foreach (var entry in ChampDto.Data)
        {
            Champlist.Add(entry.Key);
        }
        */

        using (SqlConnection conn = new SqlConnection(ChampDB))
        {
            // Connections must be opened
            conn.Open();

            // Database commands should be executed within a transaction.  When commands 
            // are executed within a transaction, either all of the commands will succeed
            // or all will be canceled.  You don't have to worry about some of the commands
            // changing the DB and others failing.
            using (SqlTransaction trans = conn.BeginTransaction())
            {
                // An SqlCommand executes a SQL statement on the database.  In this case it is an
                // insert statement.  The first parameter is the statement, the second is the
                // connection, and the third is the transaction.  
                //
                // Note that I use symbols like @UserID as placeholders for values that need to appear
                // in the statement.  You will see below how the placeholders are replaced.  You may be
                // tempted to simply paste the values into the string, but this is a BAD IDEA that violates
                // a cardinal rule of DB Security 101.  By using the placeholder approach, you don't have
                // to worry about escaping special characters and you don't have to worry about one form
                // of the SQL insertion attack.
               // for (int i = 0; i < 130; i++)
               // {


                    using (SqlCommand command =
                        new SqlCommand("insert into Test2 (Name) values(@Name)",
                                        conn,
                                        trans))
                    {
                        // We generate the userID to use.
                        string userID = Guid.NewGuid().ToString();

                        // This is where the placeholders are replaced.
                        command.Parameters.AddWithValue("@Name", champ);


                        // This executes the command within the transaction over the connection.  The number of rows
                        // that were modified is returned.  Perhaps I should check and make sure that 1 is returned
                        // as expected.
                        command.ExecuteNonQuery();

                        // Immediately before each return that appears within the scope of a transaction, it is
                        // important to commit the transaction.  Otherwise, the transaction will be aborted and
                        // rolled back as soon as control leaves the scope of the transaction. 
                        trans.Commit();


                    }
                //}
            }
        }
    }


}