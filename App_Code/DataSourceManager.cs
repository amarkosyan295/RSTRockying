using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Xml;
using System.Xml.Xsl;
using System.IO;
using System.Text;

namespace Rockying.Models
{

    public class DataSourceManager
    {
        public DataSourceManager()
        {

        }

        public string LoadContent(string name)
        {
            if (CacheManager.Get<string>(name) != null)
            {
                return CacheManager.Get<string>(name);
            }
            else
            {
                CustomDataSource cds = GetByName(name);
                if (cds != null)
                {
                    if (cds.Query.Trim() == string.Empty)
                    {
                        CacheManager.Add(name, cds.HtmlTemplate.Trim(), DateTime.Now.AddDays(2));
                        return CacheManager.Get<string>(name);
                    }
                    else
                    {
                        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                        {
                            dc.Connection.Open();
                            SqlCommand comm = new SqlCommand(string.Format("{0} FOR XML RAW , ROOT('DataSource'), Elements;", cds.Query), dc.Connection as SqlConnection);
                            XmlReader reader = comm.ExecuteXmlReader();
                            if (reader.Read())
                            {
                                string data = string.Format("<xsl:stylesheet version=\"1.0\" xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\" xmlns:msxsl=\"urn:schemas-microsoft-com:xslt\" exclude-result-prefixes=\"msxsl\"> <xsl:output method=\"xml\" omit-xml-declaration=\"yes\" /> {0} </xsl:stylesheet>", cds.HtmlTemplate.Trim());
                                // Load the style sheet.
                                XslCompiledTransform xslt = new XslCompiledTransform();
                                XmlReader xmlread = XmlReader.Create(new StringReader(data));
                                xslt.Load(xmlread);

                                // Execute the transform and output the results to a file.
                                StringBuilder builder = new StringBuilder();
                                XmlWriter xmlOutput = XmlWriter.Create(builder);

                                xslt.Transform(reader, xmlOutput);
                                CacheManager.Add(name, builder.ToString(), DateTime.Now.AddDays(2));
                                return CacheManager.Get<string>(name);
                            }
                        }
                    }
                }
            }

            return string.Empty;
        }

        public string ParseAndPopulate(string input)
        {
            string output = input;

            HtmlAgilityPack.HtmlDocument doc = new HtmlAgilityPack.HtmlDocument();
            doc.LoadHtml(input);
            if (doc.DocumentNode.SelectNodes("//datasource") != null)
            {
                foreach (HtmlAgilityPack.HtmlNode ds in doc.DocumentNode.SelectNodes("//datasource"))
                {
                    HtmlAgilityPack.HtmlAttribute att = ds.Attributes["name"];
                    if (att != null)
                    {
                        try
                        {
                            HtmlAgilityPack.HtmlNode hn = HtmlAgilityPack.HtmlNode.CreateNode(string.Format("", LoadContent(att.Value)));
                            var temp = doc.CreateElement("temp");
                            temp.InnerHtml = LoadContent(att.Value);
                            var current = ds;
                            foreach (var child in temp.ChildNodes)
                            {
                                ds.ParentNode.InsertAfter(child, current);
                                current = child;
                            }
                            ds.Remove();
                        }
                        catch { }
                    }
                }
            }
            output = doc.DocumentNode.OuterHtml;
            return output;
        }

        public void Refresh(string name)
        {
            CacheManager.Remove(name);
        }

        public bool Add(string name, string query, string template, long memberid)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                CustomDataSource item = new CustomDataSource();
                item.Name = name;
                item.Query = query;
                item.HtmlTemplate = template;
                item.DateCreated = DateTime.Now;
                item.CreatedBy = memberid;
                dc.CustomDataSources.InsertOnSubmit(item);
                dc.SubmitChanges();
                return true;
            }
        }

        public bool Update(int id, string name, string query, string template, long memberid)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                CustomDataSource item = (from t in dc.CustomDataSources where t.ID == id select t).SingleOrDefault<CustomDataSource>();
                item.Name = name;
                item.Query = query;
                item.HtmlTemplate = template;
                item.ModifiedBy = memberid;
                item.DateModified = DateTime.Now;
                dc.SubmitChanges();
                return true;
            }
        }

        public bool Delete(int id)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                CustomDataSource item = (from t in dc.CustomDataSources where t.ID == id select t).SingleOrDefault<CustomDataSource>();
                dc.CustomDataSources.DeleteOnSubmit(item);
                dc.SubmitChanges();
                return true;
            }
        }

        public CustomDataSource GetById(int id)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                return (from t in dc.CustomDataSources where t.ID == id select t).SingleOrDefault<CustomDataSource>();
            }
        }

        public CustomDataSource GetByName(string name)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                return (from t in dc.CustomDataSources where t.Name == name select t).SingleOrDefault<CustomDataSource>();
            }
        }

    }
}