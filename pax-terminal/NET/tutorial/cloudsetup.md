---
title: Setting Up For Cloud
description: |
    The cloud solution is using OAuth2 with client credential grant type. Before anything can |
    happen the credentials must be in place and an accesstoken retrieved.
permalink: /:path/cloudsetup/
menu_order: 68
---

When using the Net SDK the credentials are encrypted and stored locally in a configuration file - `SwPTrmLib.dll.config`. The encryption is only valid on the specific machine so the file cannot be copied to another machine. The file is created and maintained through the interface `IConfigInit` which contains two methods for setting client id and the secret. To retrieve the interface use the static methods `ConfigInit.Create4Test()` or `ConfigInit.Create4Prod()`.

{:.code-view-header}
**The simple interface for creating a config file with credentials.**

```c#
namespace SwpTrmLib.Cloud
{
    public interface IConfigInit
    {
        void SetClientId(string id);
        void SetClientSecret(string secret);
    }
}
```

There will be one config file per POIID, so the `SwPTrmLib.dll.config` is just used as a template for the poiid config file which name is `<POIID>.dll.config`. The POIID configuration file is created when calling `ISwpTrmIf_1.Start`. If the template file doesn't exist it is created but then without credentials. You may copy the credentials in clear into the template file and then remove the created POIID config file and call `ISwpTrmIf_1.Start` again. The credentials are then encrypted and a new configuration file for the POIID is created. This approach is not the easy way. The preferred way is to create the file with credentials before calling `ISwpTrmIf_1.Start`.

The credentials are valid for 24 months so make sure they are easily maintained. The Client id and secret is valid per partner or integrator in most cases.

{:.code-view-header}
**Example of contetent of a config file. This is after pairing has been done.**

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration>
    <appSettings file="">
        <clear />
        <add key="Secret" value="AQAAANCMnd8BFdERjHoAwE/Cl+sBAAAAI24frRP+ake+Phr6N48kagAAAAACAAAAAAAQZgAAAAEAACAAAAARMa8uFnu+o/BF5lQ2hkxiqZWrzYW/m5t+0jer6MIvHAAAAAAOgAAAAAIAACAAAACKPAae2vD72iTFTHGTvHazVNsDJ56xfSoSfP35tqHYxDAAAAD6mjteYVnzayZEgZgoTgaBlXr1ApkrayqiuESBvN4tqta3RNSCysU/lO1X+RqQJh1AAAAAuozjgk8hQ0W2PlBnzeH9dNYCvTVgx/t+GUHMPCrAx9TbxLiiR6IIA4EFNl2i3oEaSRf4fdGK+XEmRsBi+jGlSA==" />
        <add key="ClientId" value="AQAAANCMnd8BFdERjHoAwE/Cl+sBAAAAI24frRP+ake+Phr6N48kagAAAAACAAAAAAAQZgAAAAEAACAAAABeHQmVwuFg3fUKhFPZHbjNt8olaZRHzEGSHGPcG625UAAAAAAOgAAAAAIAACAAAAAjKPUYPs73dq9rfkl6kzbKtGelg7kUw9L0Uzgqiw3NGTAAAACWObx14RnCzb313OG9cAPjiorUv5KOwQ1R5lZl3jdTA+ERPxW06mbVR7CJPTwn6y9AAAAAbkzaJEh/BmcOV/doaE0ngpm7+iLMrrHJEoc1m0ZRGRbQy+D2E4uL5+UhMROidCkGxxWSX0ZIUiWyaP0xbjF4NQ==" />
        <add key="Scope" value="https://swppciextdev.onmicrosoft.com/terminal-api/.default" />
        <add key="GetTokenUrl" value="https://swppciextdev.b2clogin.com/swppciextdev.onmicrosoft.com/B2C_1_terminal/oauth2/v2.0/token" />
        <add key="BaseURL" value="https://cloudconnect.stage.swedbankpay.com" />
        <add key="PairingUri" value="/api/v1/pairing" />
        <add key="NexoUri" value="/api/v1/channels/#channelid#/nexo" />
        <add key="EventsUri" value="/api/v1/channels/#channelid#/events" />
        <add key="AccessToken" value="AQAAANCMnd8BFdERjHoAwE/Cl+sBAAAAI24frRP+ake+Phr6N48kagAAAAACAAAAAAAQZgAAAAEAACAAAADYP+Droh65YD6QOzGPToTwKVDgMeQ1YU0yldqiw/sMlwAAAAAOgAAAAAIAACAAAAB7Kejh8VmSVFv3QElHX+91ckfliOWAc2x6iwR7FHkDDxAEAABiWPFFd9n0H5uBS7Swhrxu58Fj8HHrzSXM51Ff8kOAd6gDCwvaJ+tysoMUVsFa3b0NIT2UvECFnx70sok+jq68jq/tsoA1vlkrSWRwmK3gcN1E10C3S8ABiG2A4TdHKf3XwHy6ZxxwOVRZwVyWMXUGP2rwMPRua+VxtZspexmQNJb2gUsvNSHLO0TCGwrkHXcUSlLWS3KXLjYmC+Vr4fTWml6ObEZTUlaDO8qdWjVjTyveUZbrxIS3KgkE9sv2dal/e+V4VYcXRlDe5NS4ardiMUVj0sOQIp7gzvrd+KrQHn3Zjz9x+w7sincbofXyEod33Co8dpvfUgCxY+MQskyfRTZIgzai+DY8Cvngmf/w8R9B9/7/xw6MioOkqGhW/sgsUMZLX3u9iUegcDIiQWN/YzFQ4wyiYFo2OcYh7k6Lx9IyW9fPFoTE6NlNtXartLaMx2UAcmjddhTjlXe2DZSzQt6XKdtYp27roDJtQ1RsTnETMPlyDIohMMNn6SIUosE2b8v+ndI3FYOanmPTDJq4mMl7b3dxighlyQrgp4DQfYunvOuKHl3o0Nu8gThQfE5uCZGmr0znMxkkDAi11oof9lYWw/0Sy42+g4EKzwWUO8nmEdqTyAeOLd2Hh6vbbxm65XAueeajxlXCd1pGDQfVNc3zwdt5FaWJAtoLgYU7Jqp4nwWqCQ9V3Mf+BxK+pJ8tJtcuutyqJC93167Pl8rkMy9EDLUnVlOeM0CgzJTrUV5LIi9f1U158CpZSktjTPjIZ7rolx16ag3YkydnsknNVw1nTzfCiQdBX/NfeCHACR8t/TxlomffVsmGJy5uXD4YKCAlzKctYzDWKA46gA2GSZ2vRvANCKCgAeKXbG17394a8s5cIsY0S8N1XMN536Suzp21gMKuCGtVhWuV+A4BVC5O+lJiIF36oHACCL3hmwV4lxcgmF9PshhtyJDD5pdao55QbJpBUF8yLdvAtEtOOYUT9KYQtvKamaHXyjZZQ4YTHqXievy+g/YGJcRyBQj2CaSkImICvUq8Lrw+fosgiw/kbRAKZEFhNl2tG2haRkdR4LkE0el4NXrPQEsPaDKVlTsjJVgSXvxk/iGnczOfdzjaIKs6ZJFYrdiZ8cyRA1VgWkBDnNnOX2m4HJcgkxplLinN2r83499IeuMX6qGXqNspBDk2QoN5CSbWBFTgKiVPdybH16XgB7vgl5viXRBtVNZk/jHA3YuE3o+x3B6hDTX6JSpzEl8YS1DKN2DwfPUqYGSfeC12ylDdVqaXfvuxSfZMC8zypDF0vSVR0zZCui6Qgu6OlEyeFh6g+sYlVpB3p5oWX7BNIHic3MO2jL2cNuM32mJvbpYS/TIB2z2dGHzpKKp/OwCyLFP+y+qRUEAAAADiPjd0QwCrZ9xPRso+MzXAFhVavy1cl5a2yO/zFbWZWSb174RVjWJKgh3BpIFhvrfRYV3rDuA8cjICH5+/pDqF" />
        <add key="ExpiresOn" value="2025-12-17 16:40:22" />
        <add key="RenewAt" value="2025-12-17 16:30:22" />
        <add key="ChannelID" value="AQAAANCMnd8BFdERjHoAwE/Cl+sBAAAAI24frRP+ake+Phr6N48kagAAAAACAAAAAAAQZgAAAAEAACAAAACZniBBkZ++sh/moOLZuUgRTOpAirCOoyYLc67fBuse5wAAAAAOgAAAAAIAACAAAABI1Ve11tm8JMgl0nv3HV7ylXETsN7o7zkaFMXGIXxnLTAAAACLjO9PdkRS0qW76VMF0cSL6bRRKclsnLfSnrQvdvcZP5b5U7TW44BAAQ6ennDDgDpAAAAAstcvWUu6Md9uDycRi8z4GAr5K0V2EG0xaelNfBP1hAxe/uddbu95GnS0qtA7+Mt3FLegu3MByX2f1ii5qoYyCQ==" />
    </appSettings>
</configuration>
```

## Creating config file through IConfigInit

The following shows a simple console program that creates a config template file with encrypted client id and secret.

{:.code-view-header}
**A simple Console program for creating a config file with credentials.**

```c#
// See https://aka.ms/new-console-template for more information
using CommandLine;
using System.Runtime.CompilerServices;
using SwpTrmLib.Cloud;

Console.WriteLine("Create SwpTrmLib.dll.config");

SwpTrmLib.Cloud.IConfigInit? config;

if (args.Length == 0)
{
    args = new string[] { "--help" };
}
var options = Parser.Default.ParseArguments<Options>(args);
if (options.Errors.Count() == 0)
{
    if (options.Value.test)
    {
        Console.WriteLine("Config template for test environment.");
        config = ConfigInit.Create4Test();
    }
    else
    {
        Console.WriteLine("Config template for production environment.");
        config = ConfigInit.Create4Prod();
    }

    if (!string.IsNullOrEmpty(options.Value.ClientID))
    {
        config.SetClientId(options.Value.ClientID);
    }
    if (!string.IsNullOrEmpty(options.Value.Secret))
    {
        config.SetClientSecret(options.Value.Secret);
    }
    if (config != null) fixGetTokenUrls();
}

Console.WriteLine("Done!");

void fixGetTokenUrls()
{
    string text = File.ReadAllText("SwpTrmLib.dll.config");
    text = text.Replace("B2C_1_default", "B2C_1_terminal");
    File.WriteAllText("SwpTrmLib.dll.config", text);
}
public class Options
{
    [Option('t',"test", Required=false, HelpText ="Generates config file with url:s for test.")]
    public bool test { get; set; }

    [Option('p', "prod", Required = false, HelpText = "Generates config file with url:s for prod.")]
    public bool prod { get; set; }

    [Option("clientid",Separator='=', Required =false, HelpText ="Oauth2 client id")]
    public string ClientID { get; set; }

    [Option("secret", Separator = '=',Required = false, HelpText = "Oauth2 secret")]
    public string Secret { get; set; }
}

```