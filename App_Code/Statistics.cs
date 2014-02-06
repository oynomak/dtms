using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for Statistics
/// </summary>
public class Statistics
{
    public Statistics()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public string MonthStart()
    {
        DateTime dt;
        dt = DateTime.Now.AddDays(-1 * (DateTime.Now.Day - 1));
        return dt.ToShortDateString();
    }

    public string MonthEnd()
    {
        DateTime dt;
        dt = DateTime.Now.AddDays(DateTime.DaysInMonth(DateTime.Now.Year, DateTime.Now.Month) - DateTime.Now.Day);
        return dt.ToShortDateString();
    }

    public string YearStart()
    {
        DateTime dt;
        dt = DateTime.Parse("1/1/" + DateTime.Now.Year.ToString());
        return dt.ToShortDateString();
    }

    public string YearEnd()
    {
        DateTime dt;
        dt = DateTime.Parse("12/31/" + DateTime.Now.Year.ToString());
        return dt.ToShortDateString();
    }

    public string WeekStart()
    {
        DateTime dt;
        dt = DateTime.Now.AddDays(-1* (int)DateTime.Now.DayOfWeek);
        return dt.ToShortDateString();
    }

    public string WeekEnd()
    {
        DateTime dt;
        dt = DateTime.Now.AddDays(6 - (int)DateTime.Now.DayOfWeek);
        return dt.ToShortDateString();
    }

    public static bool IsNumeric(string number)
    {
        for (int i = 0; i <= number.Length - 1; i++)
        {
            if (char.IsNumber(number[i]) == false)
            {
                return false;
            }
        }

        return true; 
    }
}
