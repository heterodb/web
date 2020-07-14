---
hide_toc: on
with_contact_form: on
---

<h1 class="section" id="about_heterodb">
@ja:HeteroDB会社概要
@en:about HeteroDB
</h1>

@ja{
- **会社名**: ヘテロDB株式会社
- **英文表記**： HeteroDB,Inc
- **所在地**: 東京都品川区北品川5-13-15-403
- **設立**: 2017年7月4日(火)
- **資本金**: 999万円
- **代表者**: 海外 浩平
- **事業内容**:
    - 大量データ処理向けソフトウェア製品の開発、保守
    - データベース、GPU、Linux関連技術コンサルティング
    - データベース、オープンソース領域の技術開発
- **問い合わせ先**
    - :fa-envelope: contact@heterodb.com
    - :fa-phone: 03-6409-6445
}
@en{
- **Corporate Name**: HeteroDB,Inc
- **Location**: 5-13-15-403, Kita-Shinagawa, Shinagawa-ku, Tokyo, Japan
- **Date of establishment**: 4th-July-2017
- **Legal capital**: 9.99M JPY
- **CEO**: KaiGai Kohei
- **Business Area**:
    - Sales and support of big-data processing software
    - Consulting service at database, GPU and Linux technology
    - Development of database and open source software
- **Contact**
    - :fa-envelope: contact@heterodb.com
    - :fa-phone: +81-3-6409-6445
}

<!--
<h1 class="section" id="location">
@ja:会社所在地
@en:Office Location
</h1>

@ja{
- JR横須賀線 西大井駅より徒歩1分
}
@en{
- 1 min on walk from the Nishiooi-station at JR Yokosuka-line
    - 13min from Tokyo-station, 4min from Shinagawa-station on the Yokosuka-line
}
<iframe src="https://www.google.com/maps/d/embed?mid=1H35V4uTydwyscuOomnBNQOqcNK8&hl=ja" width="640" height="480"></iframe>
-->

<h1 class="section" id="team">
@ja:代表者プロフィール
@en:CEO Profile
</h1>

![KaiGai Kohei Profile](./img/kaigai_profile.jpg)

<span style="font-size: 125%">
@ja:海外 浩平 | KaiGai Kohei
@en:KaiGai Kohei
</span>

@ja{
PostgreSQLやLinux kernelなどオープンソースソフトウェアの開発に10年以上従事。セキュリティ機能強化やFDW/CSP開発への貢献により、PostgreSQLコミュニティではMajor Contributorとして知られる。

2012年に最初のバージョンのPG-Stromを公開。以降、GPUやSSDによるデータベース高速化技術にのめり込み、この技術の製品化を目指して2017年にHeteroDB社を設立。現在に至る。

2007年 IPA未踏ソフトウェア創造事業において天才プログラマ／スーパークリエータ認定。2014年 日本OSS推進フォーラムよりOSS貢献者賞受賞。

筑波大学 情報学類卒業、同 大学院 経営・政策科学研究科修了
}
@en{
He has more than 10 years experiences for open source software development like PostgreSQL, Linux kernel and so on. He is also known as a major contributor in the PostgreSQL community due to enhancement of security feature and development of FDW/CSP.

He released the first version of PG-Strom in 2012, then has focused on database acceleration technology using GPU/SSD. In 2017, he established HeteroDB,Inc for productization of this technology.

2007, Genius programmer/super creator award by IPA. 2014, OSS contributor's award by Japan OSS Promotion Forum.

Bachelor of computer science, University of Tsukuba. Master of business administration, University of Tsukuba.
}

<h1 class="section" id="oss_community">
@ja:オープンソースコミュニティの一員として
@en:As a member of open source community
</h1>

@ja:## PostgreSQL本体機能への貢献
@en:## Contributions for PostgreSQL development

@ja{
- CustomScanおよびForeignScanに対する`shutdown`コールバックの追加 (v10)
- Introduce extensible node types (v10)
- CustomScanおよびForeignScanに対する並列処理機能の対応 (v9.6)
- CustomScanおよびForeignScanを用いたJOIN-pushdown機能の強化 (v9.5)
- CustomScanインターフェースの提供 (v9.5)
- 外部テーブルラッパー(FDW)による外部テーブルへの書き込み（inserts/updates/deletes）対応(v9.3)
}
@en{
- Allow custom and foreign scans to have shutdown callbacks. (v10)
- Introduce extensible node types (v10)
- Allow parallel custom and foreign scans. (v9.6)
- Allow foreign data wrappers and custom scans to implement join pushdown (v9.5)
- Allow custom path and scan methods (v9.5)
- Allow foreign data wrappers to support writes (inserts/updates/deletes) on foreign tables (v9.3)
}

@ja:## コミュニティイベントでの発表
@en:## Talks at community conferences

- PGconf.ASIA 2019 (Bali, Indonesia)
- Deep Learning Community#10 (Tokyo, Japan; 2019-05-16) [[slides]](https://www.slideshare.net/kaigai/20190516dlc10pgstrom)
- PGconf.ASIA 2018 (Tokyo, Japan; 2018-12-11) [[slides]](https://www.slideshare.net/kaigai/20181211-pgconfasia-nvmessdgpu-for-bigdata)
- PGconf.EU 2018 (Lisbon, Portugal; 2018-10-26) [[slides]](https://www.slideshare.net/kaigai/20181016pgconfeussd2gpumulti)
- DB Tech Showcase 2018 (Tokyo, Japan; 2018-09-20) [[slides]](https://www.slideshare.net/kaigai/20181016pgconfeussd2gpumulti)
- GPU Technology Conference Japan 2018 (Tokyo, Japan; 2018-09-14) [[slides]](https://www.slideshare.net/kaigai/20180914-gtcj-inception-heterodb)
- GPU Technology Conference Japan 2017 (Tokyo, Japan; 2017-12-12) [[slides]](https://www.slideshare.net/kaigai/20171212gtcjapaninceptionsummtheterodb)
@ja:    - 本カンファレンスにおいて Inception Award を受賞。[[日経新聞]](https://www.nikkei.com/article/DGXMZO24542480S7A211C1XY0000/)
@en:    - We won a prize of NVIDIA Inception Award [[Nikkei]](https://www.nikkei.com/article/DGXMZO24542480S7A211C1XY0000/)
- DB Tech Showcase 2017 (Tokyo, Japan; 2017-09-06) [[slides]](https://www.slideshare.net/kaigai/gpussd-accelerates-postgresql-challenge-towards-query-processing-throughput-10gbs)
- Open Source Summit Tokyo 2017 (Tokyo, Japan; 2017-05-31) [[slides]](https://www.slideshare.net/kaigai/20170602ossummitanintelligentstorage)
- GPU Technology Conference 2017 (San Jose, CA) [[poster]](blob/P7130_KAIGAI_SSD2GPU.pdf)
@ja:    - ポスターセッションのTop-5に選出。来場者の投票では次点に。
@en:    - Our poster was chosen as top-5; took a second place by voting
- PGconf.ASIA 2016 (Tokyo, Japan) [[slides]](https://www.slideshare.net/kaigai/pgconfasia2016-plcuda)
- PGconf.SV 2016 (San Francisco, CA) [[slides]](https://www.slideshare.net/kaigai/pgconfsv2016-plcuda)
- PostgreSQL Conference Japan 2015 (Tokyo, Japan; 2015-11-27)
- PGconf.EU 2015 (Wien, Austria; 2015-10-30)
- PGcon 2015 (Ottawa, Canada; 2015-06-20)
- SFPUG Meetup (San Francisco; 2015-03-18)
- DB Tech Showcase 2014 (Tokyo, Japan; 2014-11-13)
- PGconf.EU 2012 (2012-10-26)

