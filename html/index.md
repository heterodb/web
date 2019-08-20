---
hide_toc: on
with_contact_form: on
---

<h1 class="section">
@ja:増え続けるログデータの管理、集計から解析・機械学習まで対応したデータ管理基盤
@en:A unified data platform for log-data processing, analytics and machine-learning
</h1>
@ja{
![PG-Strom usage](img/product_01j.png)

PG-Stromは最も広範に利用されているDBシステムの一つ、PostgreSQLの拡張モジュールで、数十TB・数百億件といった規模の大量データの管理、集計、加工といった処理を、GPUやNVME-SSDといった最新のハードウェアの能力を最大限に引き出して高速に実行するためのソフトウェアです。

PG-Stromの各種機能は特に、IoT/M2Mといった極めて大規模のデータを扱う領域のログ処理に重点を置いており、DBシステムへのデータの取り込み、データの集計や加工、および異常検知など機械学習アプリケーションとの連携を、シンプルなシングルノード構成のDBサーバで実現します。

これらの特性は、システムコストの削減や大量データの移動に伴う入出力時間の削減といった分かりやすい効果に加えて、全てのオペレーションが多くのエンジニアにとって使い慣れたPostgreSQLシステムの中で動作するため、これまでのスキルや運用ノウハウを引き継ぐ事が可能となり、アプリケーションの品質にも寄与します。
}

@en{
![PG-Strom usage](img/product_01e.png)

PG-Strom is an extension of PostgreSQL that is one of the most widely used DB systems. This software is designed for acceleration of terabytes and billions-rows scale data processing, summarizing and analytics, by utilization of maximum capability of GPU and NVME-SSD.

Features of PG-Strom especially focus on log-data processing of large scale accumulated data like IoT/M2M area. It allows a series of data management cycle on a simple standalone database server configuration; data import, summarizing, transformation, cooperation with machine-learning application like anomaly detection, and so on.

In addition to easy-to-understand effects such as system cost reduction and time reduction of massive data migration, all the operations works on PostgreSQL system that is familiar for many engineers, we can utilize existing skill and knowledge of database administration and also improve software quality of applications.
}

@ja:#PG-Stromを構成する中核技術
@en:#PG-Strom core technologies


@ja:##GPUによるSQLの透過的な並列処理
@en:##Transparent massive-parallel SQL execution by GPU

![SSD-to-GPU Direct SQL](img/tech_10.png)

@ja{
**GPUの特徴**

GPUには数千個のプロセッサコアが搭載されており、メモリバスは数百GB/sもの帯域を持っています。これらのハードウェアリソースは並列計算において極めて有効に作用し、CPUと比べて非常に高い価格対性能比を発揮します。
GPUが得意とする並列計算の典型例は行列演算ですが、これは大量の均質なデータに対してそれぞれ同一の演算を行うという特徴があります。SQLにも類似の処理はいくつかあり、例えば全件スキャンにおいて各レコード毎にWHERE句の条件を評価するといった処理が典型です。
}
@en{
**GPU Characteristics**

A GPU device has thousands processor cores and high performance memory bus arounds hundreds GB/s bandwidth. These hardware resources work very efficiently on parallel computing, thus GPU can offer much higher price-performance ratio than CPU.
Matrix operations are a typical parallel computing workload where GPU has advantage, because of identical calculations on massive amount of uniformed data set. SQL also has similar workloads, like evaluation of WHERE-clause for each record on full table scan, for example.
}

@ja{
**PG-Stromの概要**

PG-StromはPostgreSQL向けの拡張モジュールで、集計・解析系のSQLワークロードをGPUの並列演算能力を活かして高速化するために開発されました。
CPU集約的なワークロードである、大量レコードのWHERE句、JOIN、GROUP BY処理のGPU実行に対応しており、PostgreSQLのクエリオプティマイザがGPUでの実行を選択した場合、PG-StromはSQLからJIT(Just-in-Time)コンパイルによってGPU命令バイナリを生成し、これをGPU側で非同期・並列実行します。
}
@en{
**PG-Strom Overview**
PG-Strom is an extension for PostgreSQL, designed for acceleration of summarizing and analytic SQL workloads using parallel computing capability of GPUs.
It supports on-GPU execution of WHERE, JOIN and GROUP BY which are CPU intensive workloads. Once PostgreSQL query optimizer chooses on-GPU execution, PG-Strom generates GPU binary code from the SQL by JIT (just-in-time) compile, then asynchronously runs on GPU in massive parallel.
}

@ja{
**なぜPG-StromはPostgreSQLとシームレスな統合が可能なのか**

- 共通のクエリ
    - PG-StromはSQL構文がパースされた後の内部データ構造を参照し、GPUでのSQL実行が可能かどうかを判定します。 したがって、特別なSQL命令を与える必要はなく、"重い処理"だけを選択して透過的にGPUで実行する事ができます。
- 共通のデータ
    - PG-StromはPostgreSQLのデータ構造／ストレージ形式をそのまま使用します。そのため、特別なテーブルへデータを移行したり、データ形式を変換したりする事なく利用する事ができます。
- 共通のフック
    - PG-StromはPostgreSQLが標準でサポートする内部API(フック)のみを用いて実装されています。そのため、PostgreSQL本体へのパッチや特別な修正なしにインストールする事ができます。
}
@en{
**Why PG-Strom can cooperate with PostgreSQL seamlessly?**

- No query changes
    - PG-Strom checks an internal data structure that is already parsed from SQL statement, to determine whether it is a reasonable workload for GPU execution. So, it automatically picks up "heavy workloads" and no manual controls are needed.
- No data migration
    - PG-Strom utilizes the data structure and storage format of PostgreSQL as is, so no need to migrate your data to special tables, or transform the data format.
- No patches
    - PG-Strom is all implemented on top of the internal hooks supported by PostgreSQL, so we can install the software without any special patches or custom enhancement.
}

@ja:##ストレージの速度を最大化する SSD-to-GPU Direct SQL
@en:##SSD-to-GPU Direct SQL for maximum storage throughput

@ja{
HeteroDB社のユニーク技術、SSD-to-GPU Direct SQLテクノロジは、高速ストレージと並列プロセッサ間を直接繋ぐデータパスを構築し、NVME-SSDの物理限界に近い速度でSQLを実行し、通常は"計算のアクセラレータ"として利用されるGPUを用いてI/O中心のワークロードを高速化します。

![SSD-to-GPU Direct SQL](img/tech_11j.png)
}
@en{
SSD-to-GPU Direct SQL, is a unique technology of HeteroDB, builds a direct data path between fast storage and parallel processors, to execute SQL workloads at a speed close to the physical limit of NVME-SSD. GPU is usually considered as a "computing accelerator", but I/O intensive workloads are also accelerated.

![SSD-to-GPU Direct SQL](img/tech_11e.png)
}

@ja{
**コンセプト**

ストレージ上のPostgreSQLデータブロックを読み出してCPU/RAMへ転送する前に、まずこれらのデータブロックをGPUへ転送してSQLワークロードを処理すれば、ほとんどの場合、データ量を小さくする事ができます。GROUP BYによる集約処理まで行う事ができれば、データサイズが1/1000やそれ以下という事も珍しくありません。
これは結果として、CPU/RAMへ転送すべきI/O量を減らす事となるため、I/Oが負荷の中心であるSQLワークロードであっても、GPUの手助けによって高速化が可能となるのです。

CPUの視点からNVMe-SSDとGPUの協調動作を眺めると、あたかもストレージ機器がSQLワークロードを解釈し、明らかに不要であるデータを削除、あるいは前処理を行った上で、データが読み出されているかのように見えるのです。
}
@en{
**Concept**

Before PostgreSQL data blocks on storage are loaded and transferred to CPU/RAM, in most case, we can reduce amount of the data by direct transfer of these data block onto GPU first, and processing the SQL workloads here. If GPU can handle aggregation operations with GROUP BY, it is not rare that data size becomes 1/1000 or less.
It reduces the amount of I/O to be transferred to CPU/RAM in the results, so GPU enables to accelerate I/O intensive workloads.

From the viewpoint of CPU, the collaboration of NVMe-SSD and GPU looks an intelligent storage device which can understand SQL workloads, for elimination of definitely unnecessary rows or for pre-process to the post stage.
}
@ja{
**背景技術 - GPUDirect RDMA**

この仕組みの基盤となっているのがNVIDIA GPUDirect RDMAで、GPUデバイスメモリ上の特定の領域をホストシステムの物理アドレス空間にマップするための機能です。GPUデバイスメモリが物理アドレスを持っていれば、PCIeデバイスとのDMAの際に、この領域をデータ転送先/元として使用する事ができるようになります。この時、データ転送はCPU/RAMを介さずにPCIeデバイス同士のピアツーピアで行われます。

GPUDirect RDMAは本来、MPI over Infinibandを実現するために開発された機能ですが、カスタムLinux kernel moduleがGPUデバイスメモリとPCIeデバイスとのDMAを適切に仲介すれば、他のPCIeデバイスにも応用する事ができます。
私たちはこれを、NVMe-SSDとGPUとの間のダイレクト読み出しに利用しています。
}
@en{
**Technology Basis - GPUDirect RDMA**

NVIDIA GPUDirect RDMA is technology basis of this mechanism. It enables to map a particular region of GPU device memory on physical address space pf host systems. Once GPU device memory is mapped on, we can use this address as source or destination of DMA data transfer. CPU/RAM does not intermediate this data transfer, exchanged over PCIe bus using peer-to-peer transfer between PCIe devices.

GPUDirect RDMA is originally designed for  MPI over Infiniband, on the other hands, we can apply this feature on other type of PCIe devices as long as custom Linux kernel module intermediates DMA transfer properly.
We utilized this infrastructure for the close cooperation between NVME-SSD and GPU.
}

@ja{
**なぜGPUでI/Oワークロードを高速化できるのか？**

- ダイレクト転送
    - PostgreSQLが通常用いるファイルシステム経由のI/Oでは、ストレージからデータブロックを読み出し、アプリケーションのバッファにデータを転送するまでに何回もコピーを繰り返す事になり、これらはデータ量に比例してCPUサイクルを消費する事になります。
    - SSD-to-GPUダイレクトSQL実行を用いた場合、SSDから読み出されたデータはGPUのバッファに直接、しかも非同期に転送されます。これにより、CPUやGPUをデータコピー処理から解放し、SQLワークロードの処理という本来の仕事に全ての処理サイクルを費やす事が可能となるのです。
- データ量を減らす
    - 元々、PG-StromはPostgreSQLのレコード（行データ形式）に対して、GPU上でWHERE句、JOIN、GROUP BYを実行する機能を持っており、多くの場合、これらのSQL操作はレコード数を減少させる方向に作用するという特性があります。
    - したがって、SSDから読み出したPostgreSQLデータブロックをGPUで前処理する事により、結果としてCPU/RAMにロードすべきI/O量を減少させる事が可能となります。そのため、NVME-SSDの限界性能に近い速度でデータブロックを読み出しているにも関わらず、CPUが実際に処理すべきレコード数は非常に少ないという状況を作り出すことができます。
}
@en{
**Why GPU can accelerate I/O workloads?**

- Direct Data Transfer
    - The filesystem based I/O, used by PostgreSQL, takes multiple buffer copies on storage block read. It also consumes CPU cycles according to the data size.
    - In case of SSD-to-GPU direct SQL, data blocks loaded from SSD are put on GPU device directly and asynchronously. It releases CPU/GPU from the workload of data copy, and allows them to focus on SQL workloads processing; only CPU/GPU can do.
- Reduction of data size
    - PG-Strom originally processes WHERE, JOIN and GROUP BY on GPU device for PostgreSQL data (row data format). These SQL operations perform to reduce number of rows in most cases.
    - Thus, pre-processing data blocks of PostgreSQL read from SSD by GPU enables to reduce amount of I/O to be loaded onto CPU/RAM eventually. Even though we load data blocks from NVME-SSD very fast close to the physical limitation, CPU needs to process very small number of rows.
}

@ja:##Apache Arrow形式に対応した列データストア
@en:##Columnar data store of Apache Arrow

@ja{
多くのデータ分析系アプリケーションで利用されているApache Arrow形式の直接読み取りに対応することで、DBシステムへのデータ取り込みステップ自体を不要にし、また列データによる効率的なI/O処理により、ストレージの物理限界以上の実効SQL処理速度を実現します。
}
@en{
PG-Strom supports direct read of Apache Arrow format that is used by many of data analytics applications, so it eliminates the data importing steps to DB system, and pulls out higher effective SQL processing performance more than physical limit of storage, with efficient I/O by columnar data structure.
}

![SSD-to-GPU Direct SQL](img/tech_12.png)

@ja{
Apache Arrowとは列志向データ形式の一つで、多くのデータ分析アプリケーションが共通で利用するデータ交換用のフォーマットでもあります。そのため、C/C++やPythonなど、多くの言語でArrow形式を扱うためのライブラリが整備されています。
}
@en{
Apache Arrow is one of the columnar data format, and also a data exchange format used by many data analytics applications. So, libraries to handle Arrow format are provided for major languages like C/C++, Python and so on.
}

@ja{
**なぜデータのインポートが不要なのか?**

PG-StromはPostgreSQLの外部テーブル（Foreign Table）機能を用いて、Arrow形式データファイルをあたかもPostgreSQLテーブルであるかのように読み出し、GPUで処理する事も可能です。

通常、外部からデータを取り込んでDBで集計・解析を行う場合には、インポート処理に相応の時間を要するのが通例でした。しかしPG-StromのArrow_Fdwの場合は、ファイルを外部テーブルとしてマップするだけなので、単純なファイルコピーだけで全て完了です。
}
@en{
**Why data import is not necessary?**

PG-Strom allows to read Arrow files as like PostgreSQL tables using foreign-table interface, and also support SQL processing on GPU.

Usually, it takes tons of time to import external data-set to the database system, prior to summarizing and analyzing. On the other hands, Arrow_Fdw of PG-Strom just maps Arrow files on foreign tables, so a simple file copy completes data import.
}

@ja{
**なぜI/Oが効率的なのか?**

集計・解析系の処理では、テーブルに定義された全ての列を参照することは稀です。通常は一部の列だけを参照すれば十分で、言い換えれば、被参照列以外のデータは「ゴミデータ」であり、I/Oの帯域を無用に圧迫する事になってしまっています。

PostgreSQLのような行データでは被参照列のみをストレージから抽出する事は困難ですが、列データの場合は、列ごとにデータが隣接配置されているため、被参照列のデータだけをストレージから読み出すよう、デバイスを制御するのは容易です。
}
@en{
** Why efficient I/O**

It is not usual to reference all the columns defined at a table in the analytic workloads. Usually, it is enough to reference a part of columns, on the other words, unreferenced columns are "junk data" that consumes I/O bandwidth with no sense.

It is hard to extract only referenced columns from row-data like PostgreSQL. In case of columnar data, we can easily control the device to read only referenced columns contrastingly, because data elements are closely disposed per column.
}

@ja:##NVME-oFによるスケーラブルなストレージ
@en:##Scalable storage by NVME-oF support

@ja{
IoT/M2M領域では顕著ですが、日々のログデータを蓄積するシステムでは、必要とするストレージ容量をシステム構築時に正確に見積もる事はなかなか困難な作業です。

ローカルのNVME-SSDをサーバに搭載した場合、システムに搭載可能なストレージの容量はサーバの筐体サイズによって自ずと規定されてしまいますが、高速ネットワーク越しにNVME-SSDを利用するNVME-over-Fabric技術を利用すれば、サーバの筐体サイズに関係なく、必要に応じてストレージを追加する事が可能です。

PG-StromのSSD-to-GPU Direct SQL技術はNVME-oFに対応しており、リモートのNVME-SSDからネットワークカードを介したRDMA(Remote Direct Memory Access)により、GPUへの直接データ転送を行うことが可能です。

![SSD-to-GPU Direct SQL](img/tech_13j.png)
}

@en{
It is not an easy task to estimate the required storage capacity exactly on system installation time for the systems that collect and accumulate log-data increasing day-by-day, like IoT/M2M area.

If PCIe-based NVME-SSDs are installed on the server, the maximum storage capacity is restricted by the server chassis size. On the other hands, NVME-over-Fabric technology, that uses remote NVME-SSDs over extreme fast networks, allows to extend capacity of the storage on demand, regardless of the server chassis size.

SSD-to-GPU Direct SQL technology of PG-Strom supports NVME-oF, and allows to load data blocks from remote NVME-SSD to local GPU directly by RDMA (Remote Direct Memory Aceess) over the network cards.

![SSD-to-GPU Direct SQL](img/tech_13e.png)
}

@ja:#利用シーンのご提案
@en:#Proposition of use scenarios

@ja:##ログデータ検索&amp;集計 - セキュリティ用途
@en:##Log-data search &amp; processing - for security

![Log data search](img/concept_01.png)

@ja{
何かセキュリティ事故が発生した時、その影響範囲や原因を特定するための手掛かりとなるのは、ITシステムやネットワーク機器ののログです。
しかし多くの場合、未知の（未対策の）攻撃パターンに対してインデックス設定やパーティショニングなど、一般的なDBチューニングを事前に行うのは現実的ではない一方で、迅速な原因究明や事故レポートの作成が求められます。

PG-StromはGPUの計算能力とNVME-SSDの広帯域をフル活用して、ログデータの検索と、仮説検証のTry&amp;Errorを実行する事ができるようになります。また、現場のエンジニアが使い慣れたPostgreSQLのSQL構文や演算子を利用できるため、即戦力化する事が可能です。
}
@en{
In case of security incidents, log-data of IT systems or network facilities provide us a hint to find out the causation and scope of the impact.
However, it is not realistic scenario to apply an generic DB tuning methodology like indexing or partitioning preliminary towards unknown attack patterns, on the other hands, cause investigation and reporting are rapidly required.

PG-Strom enables fast log-search and try-&amp;-error of hypothesis by utilization of GPU's computing power and NVME-SSD's wide bandwidth. For engineers in the field, they can use SQL statements and operators of PostgreSQL which are familiar with.
}

@ja:##ビジネスインテリジェンス&amp;レポーティング
@en:##Business Intelligence &amp; Reporting

![Business Intelligence](img/concept_02.png)

@ja{
ビジネスインテリジェンス(BI)やレポーティングで多用される集計系SQLワークロードは多数のCPU/GPUコアを使用する並列処理に向いており、ストレージには高いI/Oスループットが要求されます。 PG-Stromはこの種のワークロードに最適化されており、CPU/GPU/SSD全てのハードウェアリソースを駆使する事で高速な集計処理を実現します。

そのため、従来であれば高額なDWH専用機を導入したりクラスタ構成を組んでいたシステムを、シンプルなPostgreSQLベースの構成で代替する事が可能となり、システムの導入と運用に要する費用を削減する事が可能となります。
}
@en{
Typical summarizing SQL workloads, often used for business intelligence (BI) or reporting, are suitable for parallel execution by massive CPU/GPU cores and require storage system high I/O throughput. PG-Strom is optimized to this kind of workloads, thus enables rapid summarizing with all the hardware resources like CPU, GPU and SSD.

Therefore, it allows to replace legacy systems, expensive DWH appliance or cluster based systems people often adopted in the past, by simple PostgreSQL-based solution.
}

@ja:##アノマリー検知
@en:##Anomaly Detection

![Anomaly Detection](img/concept_03.png)
@ja{
クレジットカードの不正使用や振り込め詐欺など、日々のトランザクションデータの中から犯罪性のある取引を見つけるには、“普段と違う”記録を、なるべく高い頻度で見つけだす必要があります。

PG-Stromを使えば、データベースに格納されたトランザクションデータに対して、直接、統計解析アルゴリズムに基づいた検査を実行する事ができます。これらのロジックはGPUにより高速に計算する事が可能で、また、In-database処理であるため、計算のたびにデータをエクスポートする必要もありません。
}
@en{
We need to find out “anomaly” as frequent as possible, to detect criminal transaction, like credit-card skimming or bank transfer scam, from the daily transactional records.

PG-Strom supports to run anomaly detection logic based on statistical analysis algorithms directly on the transactional records stores in the database. GPU can process this logic very fast, and no need to export the database for checking because of in-database processing.
}

@ja:#製品構成・仕様
@en:#Product Specification


- ハードウェア構成は[HW-Validation-List](https://github.com/heterodb/pg-strom/wiki/002:-HW-Validation-List#hardware-validation-list)をご確認ください。
- OS: Red Hat Enterprise Linux 


@ja:## サブスクリプション製品
@en:## Software Subscription

@ja{
> **PG-Strom Enterprise Subscription (1GPU, 1年)**
>
> - サブスクリプションはPG-Stromが利用するGPUデバイスの数だけ必要です。
>     - 注意: システムに搭載されたGPUデバイスの数ではありません
> - サブスクリプションには以下のものが含まれます
>     - 有償モジュールに対するライセンスキー
>     - 対象システムに対する技術サポートの提供
>     - ソフトウェアアップデートの提供
> - サポート対象ハードウェアは[HW-Validation-List](https://github.com/heterodb/pg-strom/wiki/002:-HW-Validation-List#hardware-validation-list)をご覧ください。
> - 価格はオープンプライスです。ページ末尾のフォームよりお問い合わせください。
}
@en{
> **PG-Strom Enterprise Subscription (1GPU, 1year)**
>
> - This subscription is required for each GPU device used by PG-Strom
>     - Note that it is not number of GPU devices installed on the target system.
> - This subscription includes below:
>     - License key for the proprietary modules
>     - Technical support of the target system
>     - Online updates of the software
> - Check [HW-Validation-List](https://github.com/heterodb/pg-strom/wiki/002:-HW-Validation-List#hardware-validation-list) for supported hardware configuration.
> - This subscription has an open price. Please contact us from the contact form at bottom of the page.
}

<!-- 以下にパートナー一覧。OKもらってから -->

