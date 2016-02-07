---
title: Howto - C# enums with additional attributes (Java enum gaps covered)
date: 2012-06-30
permalink: 2012/06/howto-c-enums-with-additional-attributes-java-enum-gaps-covered.html
layout: post
tags: [".net"]
---

Disclaimer: This post isn't going to be complete apple-to-apple and even apple-to-oranges comparison. It's going to be
 describe-the-pain-and-solution post.

# Pain

I originally come from Java world. You know, Java world is sunny, awesome and peaceful place. Ok, Ok,
enough with trolling. I believe habits and experience is programmers bless and curse. We care it to ourselves
whenever we switch platforms, teams, applications.

One thing I have used to in Java world - are enums. Not just some sort of numeric values (as C++ enums), but discrete
set of immutable entities instead. It was a little bit shocking to me to find out C# (.Net) enums don't support such
concept.

For example, please take a look to this Java code snippet

{% highlight java %}
public enum Colors {
            Red("ff0000", new Rgb(255,0,0)),
            Blue("3600ff", new Rgb(0,0, 255));

    private final String _htmlCode;

    private final Rgb _rgb;

    private Colors(String htmlCode, Rgb rgb) {
        _htmlCode = htmlCode;
        _rgb = rgb;
    }

    public  String htmlCode(){ return _htmlCode;}

    public Rgb rgbCode(){return _rgb;}

// -------------------------- INNER CLASSES --------------------------
    public static class Rgb{

        private final int r, g, b;

        public Rgb(int r, int g, int b) {
            this.r = r;
            this.g = g;
            this.b = b;
        }

        public int getR() {
            return r;
        }

        public int getG() {
            return g;
        }

        public int getB() {
            return b;
        }
    }
}
{% endhighlight %}

And usage sample:

{% highlight java %}
public class Main {

    public static void main(String[] args) {

        for(Colors c : Colors.values()){
            Colors.Rgb rgb = c.rgbCode();
            System.out.printf("%s %d (html = #%s, rgb = (%d, %d, %d)\n",
                    c.name(), c.ordinal(), c.htmlCode(),
                    rgb.getR(), rgb.getG(), rgb.getB());
        }
    }
}
{% endhighlight %}

Let's take another look into code snippets above and let's write down some key points about Java enums.
- Enums inherit from `java.lang.Enum` class (not seen here, implicit thing)
- Enum values have ordinal (numeric) value. See `Enum#ordinal()` for reference. (NB: you could specify it explicitly.
If you need some sort of controlled numeric value, you should it yourselves the same manner I did it with htmlCode and
rgbCode.
- Enum values have human readable name. See `Enum#name()` for reference.
- You are able to add as many additional attributes and behaviour to your enum type as you wish. In the sample above
I've specified 2 additional attributes: rgb color and html color codes, as well as interface methods to fetch those from
 the enum instances.

So, to recap - Java enums are quite powerful and extensible beasts. I liked those and it was quite painful do not have
them during my day/to day coding session in C#. You know the statement "if all you have is a hammer, everything looks
like a nail". And every damn problem seemed to be nailed by Java enum thing :) Every problems needs a solution though.

# Solution

With a little (ok, won't be so humble; with quite a lot actually) web-search help I found out I could use C# .Net
annotations to provide additional attributes/semantics to C# code elements. Some reading, small experiments and vuala
the following code has been born.

{% highlight csharp %}
public static class EnumExtensions
{
    public static TAttribute AttributeOf<TAttribute>(this Enum @enum)
        where TAttribute : Attribute
    {
        return (TAttribute) GetFirstOrNull(GetEnumValueAttributes<TAttribute>(@enum));
    }

    private static object[] GetEnumValueAttributes<TAttribute>(Enum @enum)
        where TAttribute : Attribute
    {
        return @enum.GetType()
            .GetField(Enum.GetName(@enum.GetType(), @enum))
            .GetCustomAttributes(typeof (TAttribute), false);
    }

    private static T GetFirstOrNull<T>(IList<T> array)
        where T : class
    {
        return array == null || array.Count <= 0 ? null : array[0];
    }
}
{% endhighlight %}

Let's also provide sample usage code snippet.

{% highlight csharp %}
public enum Colors
{
    [HtmlValue("ff0000")]
    [RgbValue(255, 0, 0)]
    Red,
    [HtmlValue("3600ff")]
    [RgbValue(0, 0, 255)]
    Blue
}

[AttributeUsage(AttributeTargets.Field)]
public class HtmlValue : Attribute
{
    public HtmlValue(string value)
    {
        Value = value;
    }

    public string Value { get; set; }
}

[AttributeUsage(AttributeTargets.Field)]
public class RgbValue : Attribute
{
    public RgbValue(int r, int g, int b)
    {
        R = r;
        G = g;
        B = b;
    }

    public int R { get; set; }

    public int G { get; set; }

    public int B { get; set; }

    public string AsString()
    {
        return string.Format("({0},{1},{2})", R, G, B);
    }
}

// test sample
[TestClass]
public class EnumTest
{
    [TestMethod]
    public void TestFeature()
    {
        var blue = EnumExtensions.Colors.Blue;
        Assert.AreEqual("Blue: html=#3600ff, rgb=(0,0,255)",
                        string.Format("Blue: html=#{0}, rgb={1}",
                          blue.AttributeOf<HtmlValue>().Value,
                          blue.AttributeOf<RgbValue>().AsString()));
    }
}
{% endhighlight %}

To recap with C#/.Net enum solution.
- With a little coding help - it's possible to provide additional attributes/semantics to enum values.
- There is still no an easy way to provide additional behavior to enum values.

However it's still better than nothing :)

# Conclusion

- C#/.Net is usable afterwards :)
- I still like Java enum thing and still think this is damn good nail for my hammer (maybe I just need to code C# much
more longer to get it the other way).

-----

It proved to be useless write. However you always feel better when you share your pain with others :)
