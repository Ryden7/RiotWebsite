<%@ WebService Language="C#" Class="ChampNameService" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using RiotApi.Net;



[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class ChampNameService : System.Web.Services.WebService
{
    private static string ChampDB;

    /*
static ChampNameService()
{
    ChampDB = ConfigurationManager.ConnectionStrings["asdf"].ConnectionString;
}
*/

    //[WebMethod]
    [System.Web.Services.WebMethod]
    [System.Web.Script.Services.ScriptMethod]
    public List<String> GetChampionNames(string prefixText, int count)
    {
        String CS = ConfigurationManager.ConnectionStrings["asdf"].ConnectionString;
        List<String> ChampNamesList = new List<string>();

        using (SqlConnection conn = new SqlConnection(CS))
        {
            try
            {


                SqlCommand cmd = new SqlCommand("Procedure", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter parameter = new SqlParameter("@param1", prefixText);
                cmd.Parameters.Add(parameter);

                conn.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while(rdr.Read())
                {
                    ChampNamesList.Add(rdr["Name"].ToString());
                }
            }
            catch(Exception e)
            {

            }
        }
        return ChampNamesList;
    }

    // [System.Web.Services.WebMethod]
    //[System.Web.Script.Services.ScriptMethod]
    public static List<string> SearchCustomers(string prefixText, int count)
    {
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["asdf"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "select Name from Test2 where " +
                "Name like @SearchText + '%'";
                cmd.Parameters.AddWithValue("@SearchText", prefixText);
                cmd.Connection = conn;
                conn.Open();
                List<string> customers = new List<string>();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        customers.Add(sdr["Name"].ToString());
                    }
                }
                conn.Close();
                return customers;
            }
        }
    }

    public void PopulateDatabase()
    {
        RiotApi.Net.RestClient.RiotClient riotClient = new RiotApi.Net.RestClient.RiotClient("c3878111-a85e-4618-86fc-c142e0bea549");

        riotClient.LolStaticData.GetChampionList(RiotApi.Net.RestClient.Configuration.RiotApiConfig.Regions.NA, null, null, null, null);

    }

    public void test()
    {
        RiotApi.Net.RestClient.RiotClient riotClient = new RiotApi.Net.RestClient.RiotClient("c3878111-a85e-4618-86fc-c142e0bea549");

        RiotApi.Net.RestClient.Dto.LolStaticData.Champion.ChampionListDto ChampDto;
        ChampDto = riotClient.LolStaticData.GetChampionList(RiotApi.Net.RestClient.Configuration.RiotApiConfig.Regions.NA, null, null, null, null);
        List<String> Champlist = new List<String>();

        foreach (var entry in ChampDto.Data)
        {
            Champlist.Add(entry.Key);
        }

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
                using (SqlCommand command =
                    new SqlCommand("insert into ChampTable (Name) values(@Name)",
                                    conn,
                                    trans))
                {
                    // We generate the userID to use.
                    string userID = Guid.NewGuid().ToString();

                    // This is where the placeholders are replaced.
                    command.Parameters.AddWithValue("@Name", Champlist);

                    // This executes the command within the transaction over the connection.  The number of rows
                    // that were modified is returned.  Perhaps I should check and make sure that 1 is returned
                    // as expected.
                    command.ExecuteNonQuery();

                    // Immediately before each return that appears within the scope of a transaction, it is
                    // important to commit the transaction.  Otherwise, the transaction will be aborted and
                    // rolled back as soon as control leaves the scope of the transaction. 
                    trans.Commit();


                }
            }
        }
    }

}
    