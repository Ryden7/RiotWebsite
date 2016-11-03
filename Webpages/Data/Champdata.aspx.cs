using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using RitoLibrary;

/// <summary>
/// Summary description for Champdata
/// </summary>
public partial class Champdata : System.Web.UI.Page
{

    protected string FirstName { get; set; }
    protected string opponentChamp { get; set; }

    protected string Sumname { get; set; }
    protected RiotApi.Net.RestClient.Dto.LolStaticData.Champion.ChampionDto testdto { get; set; }
    protected RiotApi.Net.RestClient.Dto.LolStaticData.Champion.ChampionDto testdto2 { get; set; }

    protected Champstats Championstats { get; set; }
    protected Champstats Championstats2 { get; set; }
    


    RitoLibrary.RitoAPI riotLibrary = new RitoLibrary.RitoAPI();



    void Page_Load(object sender, EventArgs e)
    {
      
        opponentChamp = HttpContext.Current.Request.QueryString["Champname"];
        Sumname = HttpContext.Current.Request.QueryString["Sumname"];
       // SecondName = HttpContext.Current.Request.QueryString["userChamp"];
        String[] list = { Sumname };
        
        int conversion;

        long summonerID = riotLibrary.GetSummonerID(list);
        long championID = riotLibrary.GetCurrentChampion(summonerID);
        Int32.TryParse(championID.ToString(), out conversion);

      //string name = a.GetChampionName(Convert.ToInt32(championID));
        FirstName = riotLibrary.GetChampionName(Convert.ToInt32(championID));

        int championID2 = riotLibrary.GetChampionIDbyChampName(opponentChamp);
        



        //Step after finding champion
        RiotApi.Net.RestClient.Dto.LolStaticData.Champion.ChampionDto dto = riotLibrary.ChampionInformation(conversion);

        RiotApi.Net.RestClient.Dto.LolStaticData.Champion.ChampionDto dto2 = riotLibrary.ChampionInformation(championID2);




        testdto = dto;
        testdto2 = dto2;

        Championstats = new Champstats();

        

        Championstats.Armor = testdto.Stats.Armor;
        Championstats.Armorlvl = testdto.Stats.Armorperlevel;
        Championstats.Attackdamage = testdto.Stats.Attackdamage;
        Championstats.Attackdamagelvl = testdto.Stats.Attackdamageperlevel;
        Championstats.Attackrange = testdto.Stats.Attackrange;
        Championstats.HP = testdto.Stats.Hp;
        Championstats.HPlvl = testdto.Stats.Hpperlevel;
        Championstats.Movespeed = testdto.Stats.Movespeed;
        Championstats.MagicResist = testdto.Stats.Spellblock;
        Championstats.MagicResistperlvl = testdto.Stats.Spellblockperlevel;

        Championstats2 = new Champstats();
        Championstats2.Armor = testdto2.Stats.Armor;
        Championstats2.Armorlvl = testdto2.Stats.Armorperlevel;
        Championstats2.Attackdamage = testdto2.Stats.Attackdamage;
        Championstats2.Attackdamagelvl = testdto2.Stats.Attackdamageperlevel;
        Championstats2.Attackrange = testdto2.Stats.Attackrange;
        Championstats2.HP = testdto2.Stats.Hp;
        Championstats2.HPlvl = testdto2.Stats.Hpperlevel;
        Championstats2.Movespeed = testdto2.Stats.Movespeed;
        Championstats2.MagicResist = testdto2.Stats.Spellblock;
        Championstats2.MagicResistperlvl = testdto2.Stats.Spellblockperlevel;











    }
    public Champdata()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public string GetChampnamefromSummoner(string SummonerName)
    {
        return "asdf";
        
        
        
    }


}