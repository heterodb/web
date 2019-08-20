---
hide_toc: on
with_contact_form: on
---

@ja:##DBチューニングサービス
@en:##Database Tuning Service

![Database Tuning Service](img/service_01a.jpg)

@ja{
PostgreSQLの内部構造に精通したエンジニアがお客様ワークロードを分析し、性能低下の原因を特定。効果、費用、期間等の観点から、問題ワークロードを高速化する最適な方法をご提案します。
}
@en{
Our professional engineer analyzes your workloads based on our detailed knowledge, identifies the causation of query slow-down. Then, we will propose an optimal approach to accelerate the problematic workloads from the viewpoint of cost-effectiveness, project period and so on.
}
@ja{
**Step-1: ワークロードの分析と診断、対策のご提案**

- お客様のワークロードを分析し、問題となっているクエリがどのような原因で性能低下を引き起こしているのか診断します。
- 分析結果に基づき、効果、費用、期間等の観点から、問題ワークロードを高速化する最適な方法をご提案します。
}
@en{
**Step-1: Analysis of the workloads, diagnosis, and proposition of measures**

- We analyze customer's workloads, then make a diagnosis why problematic queries got slow-down.
- Based on the diagnosis, we shall propose an optimal way to accelerate the problematic workloads from the viewpoint of cost-effectiveness, project period and so on.
}
@ja{
**Step-2: PostgreSQLパラメータやシステム設定の修正によるチューニング**

- 個別クエリの最適化の前に、お客様ワークロードにとって適切なPostgreSQLの設定パラメータや、ストレージを中心としたOS設定の修正をご提案します。
- これらが遠因となって非効率なクエリ実行計画が生成されたり、CPUやI/Oの稼働率が極端に低いといった状況が起こり得るため、システムの規模や特性に応じたリーズナブルな設定が必要です。
}
@en{
**Step-2: Improvement by PostgreSQL parameters and system configuration**

- We propose reasonable configuration parameters of PostgreSQL and operating system configuration around storage system, prior to individual query optimization.
- These configuration can cause inefficient query plan generation or extremely less utilization ratio of CPU or I/O, so it needs reasonable configuration according to the system scale and workloads characteristics.
}
@ja{
**Step-3: データ構造の改善やクエリの書き換えによるチューニング**

- クエリの書き換えやデータ構造の修正など、根本的なデータベースチューニングを行います。
- 特にバッチ系や解析系の処理では、クエリ最適化が十分でなく不適切な実行計画が生成された場合に、本来の実行速度よりも100倍、10000倍といった水準で遅くなってしまう事も珍しくありません。
}
@en{
**Step-3: Tuning by data structure revising and query rewrites**

- Our professional engineer applied fundamental database tuning like data structure revising or query rewrites.
- In batch or analytic queries, it is not rare that inadequate query execution plan by wrong query optimization leads 100 times, often 10000 times, slower query execution performance than the optimal grade.
}

@ja{
> **ユーザ事例**
>
> 数TB規模のDBを運用しているA社ではバッチ系処理のスローダウンが問題となり、Oracle社ExadataやAWS社RedShiftなど高速DWH製品の導入を検討し、その一つとしてPG-Stromにもお声がけいただきました。
> しかしよくよく話を聞いたところ、どうやらDBシステムの実行性能というよりも、適切でないデータ構造や非効率なクエリ実行計画が原因と考えられるケースであったため、DBチューニングサービスのご利用を提案。
> 結果、一週間程度のワークロード分析により、インデックスの絞り込み性能の不良や、不適切なクエリ実行計画が明らかになりました。最終的には、PostgreSQL v11のパーティション機能の適用と個別クエリのチューニングにより、ハイエンドDB製品の導入どころか、逆にインスタンスサイズの縮小を検討できる水準にまでDBシステム全体の高速化を実現することができました。
}
@en{
> **User case**
>
> X-company is dissatisfied with batch query slow-down on terabytes scale database, and they considered a high-end DB product like Oracle Exadata, AWS RedShift and so on. HeteroDB also had a chance to introduce PG-Strom for them.
> However, according to their explanation, it looks to us the problem comes from inadequate data structure and inefficient query execution plan, rather than the performance of query execution engine. So, we proposed our database tuning service instead of the product.
> By the result of a week investigation, it became clear that inefficient index usage and wrong query execution performance. Eventually, we pulled up the database performance by applying PostgreSQL v11 partitions and individual query tuning. Rather than adoption of a high-end DB product, the entire DB system performance could be improved to a level where it was able to consider reducint the DB instance size.
}

@ja:#R&amp;D支援サービス
@en:#R&amp;D Support Service

@ja{
- 弊社の得意領域である、PostgreSQLデータベース、Linuxオペレーティングシステム、GPUコンピューティング（NVIDIA、CUDA C）、およびその周辺領域における研究開発をお手伝いします。
}
@en{
- We support research &amp; development missions, at the technology area where we have experienced: PostgreSQL database, Linux operating system, GPU computing (NVIDIA, CUDA C), and related areas.
}
![R&amp;D Support Service](img/service_03.jpg)

@ja{
> **ユーザ事例**
>
> 高速データ処理製品を開発しているY社では、CPUを介さないデバイス～GPU間のデータ転送システムの開発に NVIDIA GPUDirect RDMA の利用を検討しており、すでにPG-StromのSSD-to-GPU Direct SQL機能の開発で当該技術領域の経験が豊富であった弊社にお声がけをいただきました。
> プロジェクトにおいては、主としてLinux kernel moduleの開発に際して、GPUDirect RDMAを利用する際の注意点や性能を引き出すためのヒント、トラブルシューティングにおいて技術的見地からの助言を行い、結果、本プロジェクトでは２ヶ月で目標性能を達成することができました。
}

@en{
> **Customer case**
>
> Y-company, develops a next-generation data processing solution, considers to utilize NVIDIA GPUDirect RDMA for peer-to-peer data transfer system between a device and GPU, CPU bypassed. They invited us to the project, because HeteroDB has been well experienced in this region by the development of SSD-to-GPU Direct SQL of PG-Strom.
> In the project, we had provided comments and propositions for use of GPUDirect RDMA, hints to pull out its performance, advices and hypothesis on trouble shooting from the technology standpoint.
> Then, the project can be closed with expected performance in two months.
}

@ja:#GPUソフトウェア開発
@en:#GPU Software Development

@ja{
- GPUやCUDA C、並列コンピューティングに精通したエンジニアが、GPU向けソフトウェアの開発をご支援します。
- お客様ワークロードの特性によっては、PG-Stromのデータフレーム機能を利用して、SQLによる柔軟なデータ処理とGPUによる大規模並列処理の組み合わせソリューションも提案が可能です。
}
@en{
- Our professional engineers who are experienced in GPU, CUDA C and parallel computing support GPU software development.
- Depending on the characteristics of customer workloads, we are able to provide a solution leveraged by the data-frame of PG-Strom we  we are able to propose a combined solution with flexible data management by SQL and large-scale parallel computing by GPU, leveraged by GPU data-frame functionality of PG-Strom.
}

@ja{
> **研究事例 - 創薬ワークロードの高速化**
>
> 創薬研究を行っているC社との共同研究により、類似化合物探索のワークロードをGPU向けに実装し直し、分割統治と共有メモリ上でのtop-k導出処理を中心としたアルゴリズムの変更により、最大で100倍もの処理性能を実現しました。
>
> ![PL/CUDA for Drug Discovery](img/service_02j.png)
>
> [PL/CUDA - In-database massive parallel analytics (GTC2017)](blob/P7129_KAIGAI_PLCUDA.pdf)
>
}
@en{
> **Research Case - Acceleration of Drug Discovery workloads**
>
> In a joint project with company-Z who researches drug discovery, we reimplemented the chemical distance similarity search algorithm for GPU devices. By the algorithm improvement with divide-and-conquer and top-k calculation on the shared memory, our software pulled out x100 times faster performance than CPU version.
>
> ![PL/CUDA for Drug Discovery](img/service_02e.png)
>
> [PL/CUDA - In-database massive parallel analytics (GTC2017)](blob/P7129_KAIGAI_PLCUDA.pdf)
}
