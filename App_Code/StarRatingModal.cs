using Rockying.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for StarRatingModal
/// </summary>
public class StarRatingModal
{
    public int RatingCount { get; set; }
    public decimal PostRating { get; set; }
    public StarRating YourRating { get; set; }
    public StarRatingModal()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}