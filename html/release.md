---
hide_toc: on
---

<h1 class="headline" id="20210616">
@ja:PG-Strom v3.0をリリースしました。
@en:PG-Strom v3.0 was released
</h1>
<p class="headline">
@ja:2021年6月16日(水)
@en:16-Jun-2021 (Wed)
</p>
@ja{
本日、PG-Strom開発者チームは、NVIDIA GPUDirect Storage対応や、GPU版PostGIS・GiSTインデックスなど新機能を含むPG-Strom v3.0をリリースしました。

主要な変更点は以下の通りです。

- NVIDIA GPUDirect Storage (cuFile) に対応しました。
- いくつかのPostGIS関数がGPUで実行可能となりました。
- GiSTインデックスを使用したGpuJoinに対応しました。
- 新たにGPUキャッシュ機能が実装されました。
- ユーザ定義のGPUデータ型/関数/演算子に対応しました。(実験的)
- ソフトウェアライセンスをGPLv2からPostgreSQLライセンスへと切り替えました。
}
@en{
Today, PG-Strom Developers Team released PG-Strom v3.0 including new features; NVIDIA GPUDirect Storage support, GPU version of PostGIS, GiST index support and so on.

Major changes in PG-Strom v3.0 are as follows:

- NVIDIA GPUDirect Storage (cuFile) is now supported.
- Several PostGIS functions are executable on GPUs.
- GpuJoin using GiST index is now supported.
- GPU Cache mechanism is newly implemented.
- User-defined GPU data types/functions/operators are experimentally supported.
- Software license was switched from GPLv2 to PostgreSQL license.
}

@ja:##NVIDIA GPUDirect Storage対応
@en:##NVIDIA GPUDirect Storage Support

@ja{
2018年4月にリリースしたv2.0以降、PG-StromではP2P-DMAを用いてCPUを介さずにNVME-SSDからGPUへデータをロードし、WHERE句/JOIN/GROUP BYといったSQL処理の一部をGPUで実行した後にホストシステムへとデータを戻す「GPUダイレクトSQL」という機能を有していました。

この機能は専用のLinux kernelドライバを用いて実装されていましたが、PG-Strom v3.0では、NVIDIA社が6月16日にリリースしたCUDA Toolkitの新機能「GPUDirect Storage」にも対応しています。
}
@en{
Since PG-Strom v2.0 released at Apr-2018, PG-Strom has supported "GPUDirect SQL" that loads data from NVME-SSD to GPU, bypassing CPU using P2P-DMA technology, and execute a part of SQL workloads like WHERE/JOIN/GROUP BY prior to the host system write back.

This feature has been implemented using a dedicated Linux kernel driver. PG-Strom v3.0 also supports the GPUDirect Storage that is a new feature of CUDA Toolkit released at 16th-June by NVIDIA.
}

![GPUDirect Storage Support](img/press_20210616a.png)

@ja{
専用ドライバではローカルのNVME-SSDからGPUへの直接データ読み出しに限られていましたが、GPUDirect Storageドライバを用いる事で、NVME-oF (NVME over Fabrics)デバイスやSDS(Software Defined Storage)デバイス、またそれらの上に構築された共有ファイルシステムからも、CPUをバイパスした直接のデータ読み出しが可能となります。

これにより、PG-Stromのストレージ層の拡張性や設計の柔軟性が大幅に向上するほか、ログデータの保存・検索に有用なApache Arrow形式を用いてのデータ交換も従来以上に容易になります。
}
@en{
The dedicated driver has supported only local NVME-SSD as a source of direct data read towards GPU. The new GPUDirect Storage driver enables direct reads bypassing CPU from NVME-oF (NVME over Fabrics) devices, SDS (Software Defined Storage) devices, or shared filesystems built on them, in addition to the local drives.

These enhancement expands the scalability and design flexibility of PG-Strom storage layer. It also makes data exchange easier using Apache Arrow files; usuful to store / search log data.
}

@ja:##GPU版PostGISとGiSTインデックス
@en:##GPU-PostGIS and GiST-index

@ja{
PG-Strom v3.0ではいくつかのPostGIS関数にGPU版を実装し、WHERE句やJOIN結合条件でこれらを使用する事ができます。
また、GpuJoinで点や多角形などのジオメトリ要素を用いた表結合を行う際には、GiSTインデックス（R木）を用いた高速な絞り込みが可能になりました。

PostGISは地理情報分析の分野で広く用いられているPostgreSQL向け拡張モジュールです。
なかでもGPU版PostGISは、携帯電話や自動車といった移動体デバイスの最新の位置情報（Real-time Location Data）と、市区町村や学区の境界といった領域（Area Definition Data）との間で行われる突合処理を主たるターゲットとしています。
}
@en{
PG-Strom v3.0 implemented several GPU version of PostGIS functions, and allows to use them in WHERE-clauses, JOIN-conditions and others.
Also, when GpuJoin joins tables using geometry items like points or polygons, it enables fast search using GiST-index (R-tree).

PostGIS is an extension module of PostgreSQL; widely used in the area of geolocation data analytics.
Among them, the GPU version of PostGIS targets to check the real-time location data of mobile devices (like smartphones, vehicles, ...) against the area definition data like boundary of municipality or school districts.
}

![GPU PostGIS and GiST index](img/press_20210616b.png)

@ja{
これらの機能強化は、例えば一定のエリア内に存在する携帯電話に広告を配信したい時、例えば一定のエリア内に存在する自動車に渋滞情報を配信したい時など、位置をキーとして該当するデバイスを検索する処理に効果を発揮します。
}
@en{
For example, when you want to deliver an advertisement to smartphonws in a particular area, or when you want to deliver traffic jam information to cara in a particular area, it is effective in the process of searching for the corresponding device using the position as a key.
}

----

@ja{
- PG-Strom v3.0 リリースノート
    - http://heterodb.github.io/pg-strom/ja/release_v3.0/
- PG-Strom プロジェクト GitHub
    - https://github.com/heterodb/pg-strom
}
@en{
- PG-Strom v3.0 Release Note
    - http://heterodb.github.io/pg-strom/ja/release_v3.0/
- PG-Strom Project GitHub
    - https://github.com/heterodb/pg-strom
}

@ja{
HeteroDB株式会社は、PG-Stromのさらなる機能強化や性能改善をはじめとしたソフトウェアの改良にコミットし『オモシロ技術をカタチにする』事にこだわっていくと共に、GPUやPostgreSQL、Linuxといった関連技術を通じてお客様システムの設計、運用、改善をサポートして参ります。
}
@en{
HeteroDB Inc has been committed to the software improvements such as further enhancements and performance improvements of PG-Strom, and sticks to making fun technologies a reality. Also, we support design, operation, and improvement of customer's system through the relevant technologies.
}

@ja{
> **本件に関するお問い合わせ先**
>
> - ヘテロDB株式会社 
> - メール: contact@heterodb.com 
> - 電話: 03-6409-6445
> - 住所: 品川区北品川5-5-15 大崎ブライトコア4F
}
@en{
> **Contact about this news**
> 
> - HeteroDB,Inc 
> - e-mail: contact@heterodb.com 
> - tel: +81(36409)6445
> - location: 5-5-15, Kita-Shinagawa, Shinagawa-ku, Tokyo, Japan
}






------

<h1 class="headline" id="20201127">
@ja:事務所移転のお知らせ
@en:HeteroDB office was relocated
</h1>
<p class="headline">
@ja:2020年11月4日(水)
@en:4-Nov-2020 (Wed)
</p>
@ja{
本日、ヘテロDB株式会社は下記の住所へ移転いたしました。

〒141-0001<br>
東京都品川区北品川5-5-15 大崎ブライトコア4F<br>
品川区産業交流施設SHIP内 416号室

心機一転、今後もPG-Stromの開発と普及に努めてまいります。
今後もお引き立てのほど、よろしくお願いいたします。
}
@en{
Today, HeteroDB was relocated to the address below:

5-5-15, Kita-Shinagawa<br>
Osaki Brightcore 4F (SHIP 416)<br>
Shinagawa-ku, Tokyo, Japan<br>
(zipcode: 141-0001)

We will strive to develop and popularize PG-Strom.
We look forward to your continued patronage.
}

![Osaki Brightcore 4F](img/press_20201104.jpg)

<iframe src="https://www.google.com/maps/d/embed?mid=1qWPEGMIIDhvyeC5PdR9LNccNm_GPdTR2" width="640" height="480"></iframe>

<h1 class="headline" id="20200915">
@ja:PostgreSQL Conference Japan 2020のスポンサーになりました。
@en:HeteroDB sponsored PostgreSQL Conference Japan 2020
</h1>
<p class="headline">
@ja:2020年9月15日(水)
@en:15-Sep-2019 (Tue)
</p>
@ja{
ヘテロDB株式会社は、2020年11月13日(金)に開催の[PostgreSQL Conference Japan 2020](https://www.postgresql.jp/jpug-pgcon2020)のシルバースポンサーになりました。
}
@en{
HeteroDB became a silver sponsor of [PostgreSQL Conference Japan 2020](https://www.postgresql.jp/jpug-pgcon2020) held at 13th-Nov-2030 (Fri).
}

![PostgreSQL Conference Japan 2020](img/press_20200915.png)

@ja{
本カンファレンスでは、弊社代表取締役の海外が『GPU が拓く地理情報分析の新たな地平 ～GPU 版 PostGIS と位置ゲームを使った検証～』と題して講演を行うほか、PostgreSQLコミュニティで長年にわたり活躍されてきたスピーカーによる、総計14のセッション、チュートリアルが予定されております。

皆さまのご参加を心待ちにしております。
}
@en{
In this conference, KaiGai Kohei (Chief Architect & CEO of HeteroDB,Inc) will have a talk entitled "The new horizon of geolocation analytics by GPU - Implementation and evaluation of GPU-edition of PostGIS", and there are 14 sessions and tutrials by excellent speakers who have worked at PostgreSQL community for a long time.

We are looking forward to see you in the conference.
}


<h1 class="headline" id="20191030">
@ja:PostgreSQL Conference Japan 2019のスポンサーになりました。
@en:HeteroDB sponsored PostgreSQL Conference Japan 2019
</h1>
<p class="headline">
@ja:2019年10月30日(水)
@en:30-Oct-2019 (Wed)
</p>
@ja{
ヘテロDB株式会社は、2019年11月15日(金)に開催の[PostgreSQL Conference Japan 2019](https://www.postgresql.jp/jpug-pgcon2019)のシルバースポンサーになりました。
}
@en{
HeteroDB became a silver sponsor of [PostgreSQL Conference Japan 2019](https://www.postgresql.jp/jpug-pgcon2019) held at 15th-Nov-2019 (Fri).
}

![PostgreSQL Conference Japan 2019](img/press_20191030.png)

@ja{
本カンファレンスでは、弊社代表取締役の海外が『PostgreSQLだってビッグデータ処理したい！！ ～GPUとNVMEを駆使して毎秒10億レコードを処理する技術～』と題して講演を行うほか、PostgreSQLコミュニティで長年にわたり活躍されてきたスピーカーによる、総計14のセッション、チュートリアルが予定されております。

皆さまのご参加を心待ちにしております。
}
@en{
In this conference, KaiGai Kohei (Chief Architect & CEO of HeteroDB,Inc) will have a talk entitled "PostgreSQL meets big-data processing!! - billion rows per second data processing by GPU and NVME", and there are 14 sessions and tutrials by excellent speakers who have worked at PostgreSQL community for a long time.

We are looking forward to see you in the conference.
}


<h1 class="headline" id="20180418">
@ja:ヘテロDB、GPUを用いたデータベース高速化技術PG-Stromの販売を開始
@en:HeteroDB released PG-Strom products for GPU acceleration of database workloads
</h1>
<p class="headline">
@ja:2018年04月18日(水)
@en:18-Apr-2018 (Wed)
</p>

@ja{
2018年4月18日、ヘテロDB株式会社（東京都品川区、代表取締役社長：海外浩平）は、GPUを用いたデータベース高速化技術であるPG-Stromのサブスクリプション製品、および同ソフトウェアを搭載したアプライアンス製品の販売を開始いたします。
}
@en{
Today, HeteroDB,Inc (Shinagawa-ku, Tokyo, Japan, CEO: KaiGai Kohei) released subscription products of PG-Strom which is GPU accelerated database technology, and appliance server product with this software.
}

@ja:##ハードウェアの能力を限界まで引き出し、1U/2UラックサーバでDWH水準の処理能力を実現する PG-Strom バージョン 2.0
@en:##PG-Strom which pull out maximum capability of the least hardware, offers DWH-class performance with 1U/2U rack server.

@ja{
PG-Stromとは、最も広く使われているオープンソースのリレーショナルデータベースであるPostgreSQL向けに設計された拡張モジュールで、SQLコマンドから自動生成したGPUプログラムをGPUの持つ数千コアと広帯域メモリを用いて並列実行する事で、大量データの集計・解析処理を高速化します。

![SSD-to-GPU Direct SQL](img/press_20180418a.png)

中核機能の一つSSD-to-GPUダイレクトSQL実行は、NVMe-SSD上のPostgreSQLデータブロックの内容をGPUへ直接ロードし、データがホストシステムに到着するよりも先にGPUでSQLワークロードを実行します。これによりCPUが処理すべきデータ量を数百分の一以下に削減し、I/O中心のワークロードである集計処理や全件探索といったワークロードを効率的に実行する事が可能となります。
}
@en{
PG-Strom is an extension module designed for PostgreSQL which is one of the most successful open source relational database management system. It automatically generates GPU programs from SQL commands, and runs SQL workloads in parallel using a few thousand cores and high-bandwidth memory of GPU, so accelerates reporting and analytics workloads to big-data.

![SSD-to-GPU Direct SQL](img/press_20180418b.png)

SSD-to-GPU Direct SQL Execution, a part of core features, directly loads data blocks of PostgreSQL on NVMe-SSD to GPU, then runs SQL workloads on the GPU prior to the data arrival at the host system. It enables to reduce amount of the data to be processed by CPU less than a few hundredth of the original, thus runs I/O intensive workloads like reporting queries or full-table scans much efficiently.
}

![Extension of PostgreSQL](img/press_20180418c.png)

@ja{
PG-StromはPostgreSQLが公式にサポートする内部APIのみを用いて実装されており、SQL構文やデータ形式なども含め、ユーザやアプリケーションからは標準的なPostgreSQLであるかのように利用できます。クエリの特性を踏まえてオプティマイザがGPUを利用するかどうかを判断するため特別なチューニングや設定は不要であり、またトランザクショナルなデータ形式（行データ）に対しても高速化を行うため、業務系システムと情報系システム間でデータ形式を変更する必要はありません。
}
@en{
PG-Strom is implemented on top of the internal APIs officially supported by PostgreSQL only, so it looks like a vanilla PostgreSQL system from the standpoint of users and applications. No special tuning and configurations are needed because its optimizer determines whether GPU shall be utilized according to the characteristics of the query. In addition, it can perform on transactional data (row-format) also, no need to convert the data format between transactional system and information system.
}
@ja{
シングルノードのPostgreSQLという最も単純な構成に必要かつ十分な処理能力を増強する事で、アプリケーションはよりシンプルな設計が可能となり、また定常的なDB管理作業の省力化にも繋がります。
}
@en{
By the enhancement of sufficient performance to single node PostgreSQL which is the simplest configuration, it allows to design application more and more simple, and also allows to reduce daily database administration jobs.
}

@ja:##PG-Stromの実行に最適なアプライアンスモデル
@en:##Appliance model optimized for PG-Strom
@ja{
PG-Stromの提供する各種のアクセラレーション機能のプラットフォームとして、最適なハードウェアを選定して予め動作検証を行い、必要なソフトウェアが全てセットアップ済みとなっているアプライアンス製品を同時にリリースします。
}
@en{
We simultaneously release an appliance server product which consists of optimal hardware components and validated as a platform of the various acceleration features of PG-Strom.
}
![Appliance Model](img/press_20180418d.png)

|        |HeteroServer GS120-P40                |
|--------|--------------------------------------|
|CPU     |Intel Xeon Gold 6126T (12C, 2.6GHz) x1|
|RAM     |DDR4-2666 32GB x 6 (total 192GB)      |
|GPU     |NVIDIA TESLA P40 (3840C, 24GB)        |
|SSD     |Intel SSD DC P4600 (2.0TB; HHHL)      |
|HDD     |2.0TB (SATA; 7.2krpm) x6              |
|Network |10Gb Ethernet x2 ports                |

@ja{
###PG-Stromの主な用途
- データウェアハウス・データマート
- バッチ・レポーティング処理
- ログデータ解析基盤
- 異常検知システム基盤
- 統計解析・機械学習基盤
}
@en{
###Major usage of PG-Strom
- Data Ware House / Data Mart
- Batch Jobs / Reporting
- Log data analytics platform
- Anomaly detection system platform
- Statistical analytics / machine-learning platform
}
@ja{
###PG-Stromの特長・主要機能
- PostgreSQLの一部として動作しクエリおよびデータの完全な互換性を実現
- SQLからGPUプログラムを自動生成し、SQLを透過的に高速化
- SSD-to-GPUダイレクトSQL実行
- インメモリ列指向キャッシュ
- GPUメモリストア(gstore_fdw)
- PL/CUDAユーザ定義関数
}
@en{
###Features and characteristics of PG-Strom
- Works as a part of PostgreSQL, thus full compatibility of data and query
- Transparent SQL acceleration with GPU and auto-generated programs
- SSD-to-GPU Direct SQL Execution
- In-memory columnar cache
- GPU memory store (gstore_fdw)
- PL/CUDA user defined function
}
@ja{
###製品一覧
- **サブスクリプション製品**
    - PG-Strom Enterprise Subscription (1GPU, 1年)
    - PG-Strom Enterprise Subscription (1GPU, 3年)
- **アプライアンス製品**
    - HeteroServer GS120-P40

- サブスクリプション製品は、[認定済みハードウェア／ソフトウェア構成](https://github.com/heterodb/pg-strom/wiki/002:-HW-Validation-List)での利用が前提となります。
- 価格は全てオープンプライスとなります

以上
}
@en{
###List of the new products
- **Software Subscription Products**
    - PG-Strom Enterprise Subscription (1GPU, 1 year)
    - PG-Strom Enterprise Subscription (1GPU, 3 year)
- **Appliance Server Products**
    - HeteroServer GS120-P40
    - Software subscription products can be used on only validated hardware / software configuration.
    - Open price for all the products
}
---
@ja{
<!-- 日本語のみ -->
あらゆる産業のIT基盤であるデータベースにGPUを活用し、処理の高速化を実現したPG-Stromは、GPUの新たな活用領域を切り開いたと言えるでしょう。PG-Stromアプライアンス製品の販売開始によって、データベース上での超高速計算・解析が簡単に活用できるようになることを期待しています。

エヌビディア 日本代表 兼 米国本社副社長　　大崎真孝様

---
}

@ja{
> **本件に関するお問い合わせ先**
>
> - ヘテロDB株式会社 
> - メール: contact@heterodb.com 
> - 電話: 03-6429-9607 
> - 住所: 品川区西大井1-1-2-206 (西大井創業支援センター内)
}
@en{
> **Contact about this news**
> 
> - HeteroDB,Inc 
> - e-mail: contact@heterodb.com 
> - tel: +81(36429)9607 
> - location: 1-1-2-206, Nishiooi, Shinagawa-ku, Tokyo, Japan
}

--------

<h1 class="headline" id="20171213">
@ja:GTCジャパン Inception Startup AIサミットにおいて、弊社が最優秀賞を受賞いたしました。
@en:HeteroDB got the best startup award at GTCJapan, Inception Startup AI summit
</h1>
<p class="headline">
@ja:2017年12月13日(水)
@en:13-Dec-2017 (Wed)
</p>

@ja{
2017年12月12日(火)～13日(水)にかけて開催されましたGPU Technology Conference Japan 2017（以下、GTCジャパン）において、『INCEPTION AI スタートアップ サミット』と題して、国内の機械学習・データサイエンス領域のスタートアップ19社によるコンテストが開催され、弊社が最優秀賞を受賞いたしました。

また、同じくGTCジャパン内のポスターセッションにおいて、弊社代表取締役・海外浩平による『PL/CUDA – In-database massive parallel analytics』と題したポスター発表が、ファイナリスト５名の中から来場者の投票により、最優秀賞を受賞いたしました。

日本で最も大規模なGPU技術カンファレンスであるGTCJapanにおいて、弊社が長年取り組んできた、GPUによる大規模データ処理の高速化、およびIn-database analyticsという新たなデータベースの適用領域に関する技術が揃って最優秀賞を受賞するというのは、大変に光栄な事であると考えております。

ユーザ様はじめ関係者の皆様のご期待に応えるべく、今後ともHeteroDB社は技術開発・製品開発に取り組んでまいります。
}
@en{
At the GPU Technology Conference Japan 2017 (hereafter; GTCJapan), held from 12-Dec to 13-Dec-2017, 19 domestic startups in the machine-learning and data-science field had presentations for their own businesses and technologies, then, we could get the award of the highest prize.

Also, in the poster session of the GTCJapan, our poster titled as "PL/CUDA - In-database massive parallel analytics", by KaiGai Kohei (CEO of HeteroDB,Inc), got the award of the best poster in the five finalist, determined by the voting of participants.

It is very honor thing to get these award in GTCJapan, which is the largest conference in the GPU technology field, towards what we have worked for long days - acceleration of large data processing by GPU and in-database analytics that expands database usages.

HeteroDB will continue to work on technology and product development in order to meet the expectations of users and everyones involved.
}
@ja{
- [最優秀はヘテロDB　米エヌビディアがAIイベント](https://www.nikkei.com/article/DGXMZO24542480S7A211C1XY0000/)
- [当日発表資料：HeteroDB,Inc ～ハードウェアの限界に挑むデータベース屋さん～](blob/20171212_GTCJapan_HeteroDB)
}
@ja{
> **本件に関するお問い合わせ先**
>
> - ヘテロDB株式会社 
> - メール: contact@heterodb.com 
> - 電話: 03-6429-9607 
> - 住所: 品川区西大井1-1-2-206 (西大井創業支援センター内)
}
@en{
> **Contact about this news**
> 
> - HeteroDB,Inc 
> - e-mail: contact@heterodb.com 
> - tel: +81(36429)9607 
> - location: 1-1-2-206, Nishiooi, Shinagawa-ku, Tokyo, Japan
}

--------

<h1 class="headline" id="20170929">
@ja:HeteroDBがNVIDIA「Inception Program」に加入しました
@en:HeteroDB Joins NVIDIA Inception Startup Program
</h1>
<p class="headline">
@ja:2017年9月29日(金)
@en:29-Sep-2017 (Fri)
</p>

@ja{
GPUを用いたデータベース高速処理技術の開発・販売を手がけるHeteroDB株式会社（東京都品川区 代表取締役社長 海外浩平、以下「HeteroDB」）は、このたび、NVIDIA Corporation（カリフォルニア州サンタクララ 社長兼CEO ジェンスン・フアン、以下「NVIDIA」）がAI・データサイエンス領域のスタートアップを支援するプログラムである「Inception Program」のパートナー企業として認定されました。

NVIDIA Inception Programへの参加により、当社はNVIDIAより最新GPUテクノロジーを含む技術支援を受け、共同でのマーケティング活動を行う事が可能となります。

HeteroDBの中核技術であるPG-Stromは、GPUによるPostgreSQLのクエリ処理ワークロードの高速化と、in-databaseのデータ解析&機械学習機能を提供するものです。本プログラムの活用を通して、HeteroDBは最新世代のGPUに最適化された高速データベース製品の研究開発を強化します。 また同時に、ヘテロジニアスコンピューティングという次世代の計算機アーキテクチャの力を、データベースという最も広範に人と社会の活動を支えているソフトウェアを通して、世界中のユーザが気軽に手の届くものになるよう、製品・ソリューションの開発に取り組みます。

NVIDIA Inception Program は、人工知能(AI)やデータサイエンスの進歩に伴い業界に革命を起こそうとしているスタートアップ企業を養成することを目的としています。Inception Programは仮想インキュベーター プログラムとして設計されており、製品開発、プロトタイピング、および導入の段階でクリティカルな状態にいるメンバーを支援します。これには、ハードウェア付与やマーケティングサポートからディープラーニングエキスパートとのトレーニングに至るまで現行のメリットのカスタムセットが含まれています。
（[http://www.nvidia.co.jp/object/inception-program-jp.html](http://www.nvidia.co.jp/object/inception-program-jp.html)）
}
@en{
HeteroDB,Inc (Shinagawa-ku, Tokyo, President: Kohei KaiGai; hereinafter HeteroDB) a leading developer and provider of high-performance database technology solution with GPUs, today announced the company has been accepted by NVIDIA Corporation (Santa Clara, CA, President & CEO: Jensen Huang; hereinafter NVIDIA) as a member of the NVIDIA Inception Program, which support startups in AI and data science.

The NVIDIA Inception Program enables HeteroDB to receive technical support including the latest GPU computing technology from NVIDIA and to conduct joint marketing activities.

HeteroDB’s core technology is the PG-Strom, which accelerates PostgreSQL’s query processing workloads, and also offers in-database analytics along with machine-learning capability. By utilizing the Inception Program, HeteroDB will strengthen the research and development for high-performance database solutions built on this core technology, optimized to the latest-generation GPUs. HeteroDB is committed in delivering the power of heterogeneous computing architecture for users around the world through databases.

NVIDIA’s Inception Program nurtures dedicated and exceptional startups who are revolutionizing industries with advances in AI and data science. A virtual accelerator program, Inception helps startups during critical stages of product development, prototyping, and deployment. Every Inception member gets a custom set of ongoing benefits, from hardware grants and marketing support to training with deep learning experts. More details about NVIDIA’s Inception program can be found at [https://www.nvidia.com/en-us/deep-learning-ai/startups/](http://www.nvidia.co.jp/object/inception-program-jp.html).
}

@ja:##HeteroDB社について**
@en:##about HeteroDB,Inc

@ja{
HeteroDB社は、GPUやNVMe-SSDなど新世代のハードウェアの能力を最大限に引き出し、データベース処理の高速化とシステム運用のシンプル化を低コストで実現するHeteroServer[*1]の開発と販売、および関連ソリューションの提供を目的として設立されたスタートアップです。 GPUとデータベースという異なる技術領域に精通したプロフェッショナル集団であり、お客様の課題に対する深い洞察から最適な解決方法をご提案します。また、イノベーションの成果を広くオープンソースコミュニティへと還元し、エコシステムの発展に寄与することを目指しています。

[*1] HeteroServer: PostgreSQLデータベースを中核に、GPU/SSDなど最新のハードウェアと、その能力を最大限に引き出すための拡張モジュールであるPG-Stromを搭載したデータベースアプライアンス製品。2018年3月のリリースを予定。
}
@en{
HeteroDB,Inc is a startup for development, sales and related solutions of HeteroServer [*1] that enables to pull out maximum capability of the latest hardware like GPUs or NVMe-SSDs, so that accelerates database workloads and simplifies system operation. We are a group of professionals at GPU computing and database systems, to provide the best solution according to deep insight to customer's problem, and to contribute innovation outcomes for open source community and growth of the eco-systems.

[*1] HeteroServer: a high-performance database appliance solution which installs the latest GPU/SSD hardware and PG-Strom extension module to pull out maximum capability of them, on top of the PostgreSQL database.
}

@ja{
> **本件に関するお問い合わせ先**
>
> - ヘテロDB株式会社 
> - メール: contact@heterodb.com 
> - 電話: 03-6429-9607 
> - 住所: 品川区西大井1-1-2-206 (西大井創業支援センター内)
}
@en{
> **Contact about this news**
> 
> - HeteroDB,Inc 
> - e-mail: contact@heterodb.com 
> - tel: +81(36429)9607 
> - location: 1-1-2-206, Nishiooi, Shinagawa-ku, Tokyo, Japan
}

--------

<h1 class="headline" id="20170728">
@ja:IPA未踏アドバンスト事業において、弊社従業員の提案が採択されました。
@en:IPA adopted our engineer's proposition for the MITOH advanced program.
</h1>
<p class="headline">
@ja:2017年7月28日(金)
@en:28-Jul-2017 (Fri)
</p>

@ja{
本日、独立行政法人情報処理推進機構（IPA）は、弊社チーフアーキテクト 海外浩平、同チーフセールスエンジニア 柏木 岳彦、同アルバイト 遠藤克浩の３名の共同提案による『ヘテロジニアスなIn-Databaseデータ解析・機械学習基盤』を含む6件を、第1回 IPA未踏アドバンスト事業の採択案件として発表いたしました。
}
@en{
Today, Information-technology Promotion Agency (IPA) announced six propositions, including "Heterogeneous In-Database Data Analytics & Machine-Learning Platform" jointly proposed by KaiGai Kohei (Chief Architect of HeteroDB), Kashiwagi Takehiko (Chief Sales Engineer of HeteroDB) and Endo Katsuhiro (Engineer of HeteroDB), get adopted to the 1st MITOH advanced program held by IPA.
}

@ja:##IPA 未踏アドバンスト事業について
@en:##about IPA MITOH advanced program
@ja{
「未踏アドバンスト事業」は、市場性、開発実現性、事業性を兼ね備えたITを活用した革新的なアイデア・プロトタイプ（製品・サービスの企画・構想を練っている段階、製品・サービスのプロトタイプ開発を継続している段階）を有し、起業または事業化に強い関心を持つ未踏的IT人材に対し、プロジェクトマネージャー等による指導・助言、活動に必要となる資金支援を行う事業です。
（[IPAウェブサイト](https://www.ipa.go.jp/jinzai/advanced/index.html)より引用）
}
@en{
IPA MITOH advanced program is a public incubation program for individual persons who have strong motivation for startup and innovative idea (or prototype) that satisfies marketability and technology/business feasibility on IT region, through financial support and advices by project manager.

(ref: [https://www.ipa.go.jp/english/humandev/third.html](https://www.ipa.go.jp/english/humandev/third.html))
}

@ja:##プロジェクトの概要
@en:##Project Overview

@ja{
本プロジェクトでは、GPUの並列計算能力を活用して解析系SQLの高速化を実現するPostgreSQL向け拡張モジュール（PG-Strom）に、次の機能を実装する。①SSD-to-GPUダイレクトSQL実行機能 （GPU/SSD密結合によるI/O高速化）、②PL/CUDA統計解析・機械学習ライブラリ（In-databaseデータ解析処理）、③行形式⇒列形式の変換に対応したストレージ機構 （ワークロード最適化SSD/キャッシュ）。これら①～③の機能を用いて、GPUやSSDといったコモディティだが強力な処理能力を有するハードウェアと、その能力を最大限に引き出すソフトウェアの組み合わせにより、リレーショナル・データベースという情報システムの中で最もデータが集積するコンポーネントをデータ解析・機械学習の基盤として再定義する。
}

@ja{
プロジェクトメンバーの設立する新会社は、前述の技術を搭載した垂直統合型高速DBシステム（仮称：HeteroServer）を製品化し、次の３セグメントをターゲットとしてこれら市場の開拓にあたる。①高性能・低価格を武器とした情報系システムの商用DBからの移行　②高速なI/Oを武器としたネットワーク事業者のログ解析　③In-database処理を武器とした金融・信販事業者のアノマリー検知。
新会社は、本垂直統合型高速DBシステムの販売（製品事業）、および、本技術を利用したデータ利活用コンサルティング（サービス事業）の２つを軸とした事業を行う。
}

@ja:##プロジェクトメンバー
@en:##Project Members

@ja{
- 海外 浩平（ヘテロDB株式会社　チーフアーキテクト 兼 代表取締役社長）
- 柏木 岳彦（ヘテロDB株式会社　チーフセールスエンジニア 兼 取締役副社長）
- 遠藤 克浩（慶應義塾大学　理工学部）
}
@en{
- KaiGai Kohei (Chief Architect & President of HeteroDB,Inc)
- Kashiwagi Takehiko (Chief Sales Engineer & Vice-president of HeteroDB,Inc)
- Endo Katsuhiro (Keio University, department of science and technology)
}

@ja:## 今後の見通し
@en:##Future Prospects

@ja{
今後、未踏アドバンストプロジェクト期間である2017年8月から2018年2月にかけて、IPAおよびプロジェクトマネージャ衛藤バタラ氏の支援、助言の下で、HeteroServer製品の中核技術であるPG-StromやPL/CUDA機械学習ライブラリの開発、およびアーリーアダプタユーザの開拓に取り組んでまいります。
}
@en{
Hereafter, we tackles the development of PG-Strom and PL/CUDA machine-learning library that is a core feature of our HeteroServer product, and the early-adopter development through the MITOH advanced project term; from Aug-2017 to Feb-2018.
}

@ja{
> **本件に関するお問い合わせ先**
>
> - ヘテロDB株式会社 
> - メール: contact@heterodb.com 
> - 電話: 03-6429-9607 
> - 住所: 品川区西大井1-1-2-206 (西大井創業支援センター内)
}
@en{
> **Contact about this news**
> 
> - HeteroDB,Inc 
> - e-mail: contact@heterodb.com 
> - tel: +81(36429)9607 
> - location: 1-1-2-206, Nishiooi, Shinagawa-ku, Tokyo, Japan
}

--------

<h1 class="headline" id="20170704">
@ja:ヘテロDB株式会社を設立しました
@en:HeteroDB,Inc was established
<h2>
@ja:〜 ヘテロジニアスコンピューティング技術のデータベース領域への適用に向けて〜
@en:- For adoption of heterogeneous computing technology onto database area -
</h2>
</h1>
<p class="headline">
@ja:2017年7月4日(火)
@en:4-Jul-2017 (Tue)
</p>

@ja{
本日、PG-Strom Development Teamのコアメンバである海外浩平、および柏木岳彦は、GPUやSSD、FPGAなどヘテロジニアス・コンピューティング技術を活用し、高性能と低価格、運用しやすさを両立するデータベース製品、ソリューション、および関連サービスを提供する新会社、ヘテロDB株式会社を設立した事をお知らせします。
}
@en{
Today, KaiGai Kohei and Kashiwagi Takehiko, who are core members of PG-Strom Development Team, established HeteroDB,Inc. The new company will provides high performance, cost effective and well administrative database product that utilizes heterogeneous computing technology, and related solution and services.
}

@ja:##新会社のミッション
@en:##Mission of the new company
@ja{
私たちは今、何十年に一度の計算機アーキテクチャの変革期という、非常に面白い時代に生きています。 ムーアの法則が終焉に近づき、プロセッサはマルチコアからメニーコアへと進化し、さらにはGPUやFPGAといった設計思想の異なる半導体デバイスを併用しなければ性能向上が見込めない世界がすぐそこまで来ています。 これらのヘテロジニアスな計算機アーキテクチャにおいては、ソフトウェアはハードウェアの進化に"ただ乗り"する事はできません。ハードウェアの能力を引き出すために、最適なソフトウェアを再設計する必要があるのです。
}
@en{
We are living in an exciting period when computer architecture is rapidly evolving once per decade. The Moore's law comes closer to its termination, processor is evolved from multi-cores to many-cores, and it becomes almost impossible to improve system performance without GPU or FPGA that are designed based on a different design concept. In case of the heterogeneous computer architecture, software cannot take a "free-lunch" of hardware evolution. Software has to be redesigned to pull out maximum performance of the hardware.
}
@ja{
私たちは、5年あまり前からGPUの並列計算能力を用いてPostgreSQLのワークロードを高速化するオープンソースの拡張モジュール「PG-Strom」の開発に取り組んできました。 ソフトウェア開発者として純粋にこの技術領域が面白いという他に、データベース管理システムという最も広範に人と社会を支えているソフトウェアの改良を通じて、さらにはオープンソースソフトウェアのエコシステムを通じて、ヘテロジニアスコンピューティングという次世代の計算機アーキテクチャの力を、世界中のユーザが気軽に手の届くものにするという使命感に支えられてのものです。
}
@en{
We have worked on development of "PG-Strom" which is an open source extension module to accelerate SQL workloads of PostgreSQL with GPU's parallel computing capability for more than 5 years. It is a quite exciting technology area from the standpoint of software developer. Plus, we have been supported by our vocation to deliver the power of heterogeneous computing that is a core of next generation computer architecture, through the database management system that widely supports human and society, and also through the eco-system of open source software.
}
@ja{
本日創業したヘテロDB株式会社は、次の３つのミッションの実現を目的としています。

- PG-Stromをはじめとする、ヘテロジニアスコンピューティング技術を組込んだデータベース製品を実現し、速さ、安さ、使いやすさを両立するデータ処理基盤を提供すること。
- GPUとデータベースという異なる技術領域に精通したプロフェッショナルであり、お客様の課題に対する深い洞察から最適な解決方法を導き出す事。
- 企業や国、技術領域の壁を越え、広くイノベーションの成果をオープンソースコミュニティに還元し、エコシステムの発展に寄与すること。

そして何より、エンジニアがわくわくするようなテクノロジーを形にし、ユーザ様ひいては社会の課題を今の時代にふさわしい形で解く事で、社会をより良くする事に貢献する企業でありたいと考えています。
}
@en{
HeteroDB,Inc we established today has the following three missions.

- To provide high-performance, cost-effective and well-administrative data processing platform, by the database product that embeds heterogeneous computing technology like PG-Strom.
- To be a professional on both of GPU and database; different technology areas, and to lead an optimal solution based on the insight to customer's problem.
- To contribute growth of eco-system of the open source community beyond companies, nations and technology areas, and to make our widespread innovation to the upstream.

Most of all, we are a company who makes exciting technologies products, and a company to contribute our society's improvement through the solutions towards user's problems by modern approach.
}

@ja{
**新会社の概要**

- 商号: ヘテロDB株式会社
- 設立: 2017年7月4日
- 代表者: 海外　浩平
- 所在地: 東京都品川区西大井一丁目１番地の２
- 資本金: 999万円
- 出資比率: 海外浩平 89.2%、柏木岳彦 10.8%
- URL： [http://heterodb.com/](http://heterodb.com/)
}
@en{
**HeteroDB Overview**

- Name: HeteroDB,Inc
- Established: 4-Jul-2017
- President: KaiGai Kohei
- Location: 1-1-2, Nishiooi, Shinagawa-ku, Tokyo, Japan
- Capital stock: 9.99M JPY
- Capital share: KaiGai Kohei (89.2%), Kashiwagi Takehiko (10.8%)
- URL： [http://heterodb.com/](http://heterodb.com/)
}
@ja{
**今後の見通し**

新会社は、PG-Stromを中核とするソフトウェアの開発、およびアーリーアダプタ利用者様との共同検証、機能・品質改善を経て、2018年3月の製品販売開始を予定しております。
}
@en{
**Future Prospects**

The new company plans production release at Mar-2018 after the software development of PG-Strom and related, joint evaluation with early-adopter users and improvement of functionality and quality.
}

@ja{
> **本件に関するお問い合わせ先**
>
> - ヘテロDB株式会社 
> - メール: contact@heterodb.com 
> - 電話: 03-6429-9607 
> - 住所: 品川区西大井1-1-2-206 (西大井創業支援センター内)
}
@en{
> **Contact about this news**
> 
> - HeteroDB,Inc 
> - e-mail: contact@heterodb.com 
> - tel: +81(36429)9607 
> - location: 1-1-2-206, Nishiooi, Shinagawa-ku, Tokyo, Japan
}

--------

<h1 class="headline" id="20170508">
@ja:弊社社員の研究発表がGTC2017のTop-5ポスターに選定されました
@en:Our research was chosen to the top-5 finalist of GTC2017 posters
</h1>
<p class="headline">
@ja:2017年5月8日(月)
@en:8-May-2017 (Mon)
</p>

![GTC2017 Top-5 Posters](img/press_20170508a.jpg)

@ja{
米NVIDIA社が主催する世界最大のGPU技術カンファレンスである GPU Technology Conference 2017（5月8日(月)～5月11日(木)、米国サンノゼ市）において、弊社チーフアーキテクトの海外による『An Intelligent Storage for PostgreSQL Database』と題したポスター発表が、約140件の研究開発ポスター発表の中からTop-5 Finalistに選定されました。
}
@en{
On the GPU Technology Conference 2017 held by NVIDIA (From 8th-May through 11th, 2017, San Jose), our research poster An Intelligent Storage for PostgreSQL Database was chosen to the top-5 finalist in the 140 research & development posters.
}
@ja{
本発表は、HeteroServer製品の中核技術の一つであるSSD-to-GPUダイレクトSQL実行機能のコンセプト、技術概要、ベンチマーク結果を紹介したものです。 その中では、TeslaシリーズGPUの機能であるGPUDirect RDMAをNVMe-SSDからのデータ読出しに応用し、不要データのふるい落としやJOIN/GROUP BYなど問い合わせ処理をGPUで並列実行してデータ量を削減する事で、従来は専ら計算集約的な問題のアクセラレータとして使用されてきたGPUを、I/O集約的な問題に対しても有効に機能することを示しています。
}
@en{
This research introduces the concept, technology overview and benchmark results of the SSD-to-GPU Direct SQL Execution feature which is one of the core functionalities of our HeteroServer product. It presents GPU devices, usually considered as an accelerator of computing intensive workloads, are also capable to work upon I/O intensive workloads using our application of GPUDirect RDMA. It is utilized to filter out unnecessary data, or to execute JOIN/GROUP BY in the middle of data flow.
}

- [GTC 2017 Posters - ACCELERATED ANALYTICS](http://www.gputechconf.com/resources/poster-gallery/2017/accelerated-analytics)
- [P7130 - An Intelligent Storage for PostgreSQL Database[PDF]](blob/P7130_KAIGAI_SSD2GPU.pdf)

@ja{
> **本件に関するお問い合わせ先**
>
> - ヘテロDB株式会社 
> - メール: contact@heterodb.com 
> - 電話: 03-6429-9607 
> - 住所: 品川区西大井1-1-2-206 (西大井創業支援センター内)
}
@en{
> **Contact about this news**
> 
> - HeteroDB,Inc 
> - e-mail: contact@heterodb.com 
> - tel: +81(36429)9607 
> - location: 1-1-2-206, Nishiooi, Shinagawa-ku, Tokyo, Japan
}

