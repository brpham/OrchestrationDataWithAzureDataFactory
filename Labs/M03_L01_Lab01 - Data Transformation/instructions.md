![](Media/image0128.png)

# Data Transformation with Azure Data Factory v2


**Introduction**

During this lab, you will learn how to perform data transformations using Azure Data Factory. This will cover data transformation using Azure Databricks and Azure Data Factory.

**Estimated Time**

45 minutes

**Objectives**

At the end of this lab, you will be able to:

> Configure a Data Transformation pipeline and perform ELT process

**Logon Information**

Use the following credentials to sign into the virtual environment

-   Username: **Administrator**

-   Password: **Microsoft1**

# Table of Contents

[Lab: Data Transformations with Azure Data Factory 3](#lab-data-transformations-with-azure-data-factory)

[Setup: Prepare your environment 3](#setup-prepare-your-environment)

[Exercise 1: Enable Microsoft.Compute 3](#exercise-1-enable-microsoft.compute)

[Exercise 2: Clone the Databricks Archive 4](#exercise-2-clone-the-databricks-archive)

[Exercise 3: Databricks Notebook 02 Data Ingestion 8](#exercise-3-databricks-notebook-01-data-ingestion)

[Exercise 4: Databricks Notebook 03 Data Transformation 20](#exercise-4-databricks-notebook-02-data-transformation)

## Lab: Data Transformations with Azure Data Factory

During this lab, you will learn how take a sample dataset to create a Data Factory pipeline and use sample notebooks in Azure Databricks to transform and analyze the data.

### Setup: Prepare your environment

You should have your storage account, databricks, and data factory resources provisioned from Module 1 (M01\_L02\_Lab01) using the Azure Resource Manager (ARM) templates. If not, please refer back to that module.

### Exercise 1: Enable Microsoft.Compute

#### Tasks

1.  Enable Microsoft.Compute

<!-- -->

1.  In the Azure portal, select **Subscriptions**.

    ![](Media/image0123.png)

2.  Select **your subscription**.

    ![](Media/image0134.png)

3.  Select Resource providers under Settings and search for **Microsoft.Compute**. Ensure it is registered. If not registered, **register it**. (Note that it takes a few minutes for the status to change from Unregistered to Registered. Refresh your browser to get an updated status, **<u>do not click</u>** the refresh button beside unregister![](Media/image0098.png" style="width:5.15588in;height:2.79167in" />

*Exercise 1 has been completed.*

### Exercise 2: Clone the Databricks Archive

This exercise will create the Databricks notebooks for the lab.

#### Tasks

1.  Launch the Databricks workspace

<!-- -->

1.  In the Azure portal, go to the resource group you created in M01\_L02\_Lab01 and select the **Databricks service**.

<!-- -->

1.  Select **Launch Workspace**.

    ![](Media/image0118.png)

<!-- -->

2.  **Create your cluster**

<!-- -->

1.  Select **Clusters** on the side panel, then **+Create Cluster.**

    ![](Media/image0106.png)

<!-- -->

2.  Enter a Cluster Name (for example: ADFTransformation)

3.  Set Cluster Mode to **Standard.**

4.  Leave Databricks Runtime Version as Default runtime – the default version may not match the screenshot

5.  Under Autopilot Options **<u>uncheck</u>** Enable Autoscaling.

6.  Set Worker type to **Standard\_DS3\_v2 and Workers to <u>1</u>**

7.  Set Driver Type to **Same as worker.**

8.  Leave everything else as default and click **Create Cluster.**

    ![](Media/image0111.png)

9.  Wait for the cluster to be created before continuing, which may take a couple of minutes.

    ![](Media/image0110.png)

<!-- -->

3.  Import the notebook

<!-- -->

1.  On the left side, select **Workspace**, then **Users**, and select your **username** (the entry with the house icon).

    ![](Media/image0109.png)

<!-- -->

10. In the window that appears, select the downward arrow next to your name and select **Import**.

    ![](Media/image0127.png)

11. In the Import Notebooks window, select import and browse to the M03\_L01\_Lab01 folder, and choose the file 03-Data-Ingestion-Via-ADF.dbc

> ![](Media/image0126.png)

12. Click the **Import** button.

13. Select the folder named **03-Data-Ingestion-Via-ADF**.

    *Note: The folder contains 3 notebooks to use in completing this lab. Run these in order, as shown below. Please note, you need to attach your notebook to the cluster you created before you can run the code.*

Exercise 2 has been completed.

### Exercise 3: Databricks Notebook 01 Data Ingestion

This exercise will create a Data Factory pipeline to ingest data from a public dataset into your storage account. After the data is ingested, you use a Databricks notebook function to examine the data.

#### Tasks

1.  **Launch your Azure Data Factory in a separate browser tab.**

    In the Azure portal, navigate to the ADF instance you previously provisioned, and then launch the Azure Data Factory UI by selecting Open in the ADF Overview blade.

    ![](Media/image0131.png)

2.  **On the ADF UI landing page, select Ingest.**

> ![](Media/image0130.png)

3.  On the Properties Page of the Copy Data wizard

<!-- -->

1.  Set the configurations as such:

    Task Type: Choose Built-in copy task:

    Task cadence or Task schedule: Choose Run once now.

2.  Select Next. ![](Media/image0129.png)

<!-- -->

4.  Configure the Source to point to the Azure Blob Storage Linked Service.

    1.  On the Source dataset page, select source type Azure Blob Storage and select + New connection.

        ![](Media/image0125.png)

5.  Configure the New Linked Service (Azure Blob Storage).

    1.  Name: PublicDataset

    2.  Authentication method: SAS URI

    3.  **SAS URL**: <https://databricksdemostore.blob.core.windows.net/?sv=2017-11-09&ss=b&srt=sco&sp=rl&se=2099-12-31T17:59:59Z&st=2018-09-22T15:21:51Z&spr=https&sig=LqDcqVNGNEuWILjNJoThzaXktV2N%2BFS354s716RJo80%3D>

    4.  Select **Test connection** and ensure a Connection successful message is displayed.

    5.  Select Create.

        ![](Media/image0121.png)

6.  Back on the Source data store page, Set the input folder.

<!-- -->

1.  Folder: Use the Browse button to select the folder training/crime-data-2016/. *Do not enter the path as text, you must use the browse button due to a bug in some versions of the interface.*

2.  Binary copy: Check this box.

3.  Recursively: Check this box.

4.  Select Next.

    ![](Media/image0120.png)

<!-- -->

7.  Configure the Target to point to Azure Blob Storage Account.

    1.  On the Target data store page, select source type Azure Blob Storage and select + New connection.

        ![](Media/image0119.png)

8.  Configure the New Linked Service (Azure Blob Storage).

    1.  Name: DestinationContainer

    2.  Authentication method: Account key

    3.  Account selection method: From Azure subscription

    4.  Azure Subscription: Azure Pass - Sponsorship

    5.  Storage account name: Select the name of the Storage account you created previously from the list.

    6.  Select Test connection and ensure a Connection successful message is displayed.

    7.  Select Create.

        ![](Media/image0124.png)

9.  Configure the output file or folder:

<!-- -->

1.  Folder path: type in the box: dwtemp/03.02/

2.  File name: Leave empty.

3.  Copy behavior: Select Preserve hierarchy.

4.  Select Next.

    ![](Media/image0122.png)

<!-- -->

10. On the Settings page,

    1.  Enter the name LabPipeline and leave the other default values

    2.  select Next

        ![](Media/image0132.png)

11. On the Summary page, you can review the copy pipeline settings

    1.  select Next

        ![](Media/image0142.png)

12. If you have <u>Do NOT</u> have Git integration enabled in your Data Factory, click Finish and then go to step 16.

    ![](Media/image0141.png)

13. If you <u>have</u> Git enabled, you will need to manually Publish and Trigger the pipeline.

    1.  Select Finish.

> ![](Media/image0140.png)
>
> Click **Publish** from the top menu bar. Review changes and click **OK**.
>
> ![](Media/image0145.png)
>
> Navigate and open your new pipeline, LabPipeline.
>
> ![](Media/image0144.png)
>
> Select **Add trigger** from the menu bar, choose **Trigger** **now** and click **OK**.
>
> ![](Media/image0143.png)
>
> Click on the **Monitor** button to the far-left.
>
> ![](Media/image0139.png)

14. Monitor the pipeline run

    Selecting Monitor above will take you to the Pipeline Runs screen in the ADF UI, where you can monitor the status of your pipeline runs. Using the monitor dialog, you can track the completion status of pipeline runs, and access other details about the run.

<!-- -->

1.  Click the pipeline under Pipeline Name to see the progress of the individual activities that make up the pipeline

    ![](Media/image0135.png)

2.  Select the various inputs, outputs, and run icons under Activity runs, Activity Name

    ![](Media/image0133.png)

<!-- -->

15. Verify files in blob storage

<!-- -->

1.  Navigate to your storage account in the Azure portal

2.  Locate the dwtemp container

3.  Locate the 03.02 folder within the dwtemp container

4.  Observe the files copied via Azure Data Factory

    ![](Media/image0138.png)

<!-- -->

16. **In the upcoming steps you will need your Storage account name and the storage account key.**

    1.  The account name and key can be retrieved from the Access keys section in your Storage account:

    2.  Copy your storage account name and Select show keys and copy the value under Key 1. Save these both for a future step.

![](Media/image0137.png)

17. **Navigate back to Databricks**

18. Select the 01-Data-Ingestion notebook from the 03-Data-Ingestion-Via-ADF Workspace

    ![](Media/image0136.png)

19. Attach the notebook to a cluster before running any cells.

    ![](Media/image0101.png)

20. Continue with the instructions in the 01-Data-Ingestion notebook to Examine the ingested data in the notebook

Exercise 3 has been completed.

### Exercise 4: Databricks Notebook 02 Data Transformation

This exercise will add a Databricks Notebook activity to your ADF pipeline that runs a sample notebook to transform and restructure your data. You will also perform some basic aggregation on the sample dataset to generate required reports.

#### Tasks

1.  Launch the Databricks workspace and navigate to the 02-Data-Transformation notebook

    ![](Media/image0100.png)

2.  Attach the notebook to a cluster before running any cells.

    ![](Media/image0099.png)

3.  Create Databricks Access Token

    This step will generate an access token that will be used by ADF to access your Databricks workspace.

<!-- -->

1.  In the top right corner of your Databricks workspace (this window), select the Account icon, and then select User Settings.

    ![](Media/image0104.png)

2.  On the User Settings screen, select Generate New Token.

    ![](Media/image0103.png)

3.  In the Generate New Token dialog, enter a comment, such as "ADF access", leave the Lifetime set to 90 days, and select Generate.

    ![](Media/image0102.png)

4.  Copy the generated token and paste it into a text editor, such as Notepad.exe, for use when setting up the Databricks Linked Service in ADF.

    *Note: Do not close the dialog containing the generated token until have save it in a text editor, as it will not be visible again once you close the dialog.*

    ![](Media/image0094.png)

<!-- -->

4.  Add Databricks Notebook Activity to Pipeline

<!-- -->

1.  Navigate back to the Azure Data Factory.

    Select the Author (pencil) icon in the left-hand menu, and select the pipeline created in Exercise 4 (LabPipeline).

    ![](Media/image0093.png)

2.  Expand Databricks under Activities, then drag the Notebook activity onto the design surface, and drop it to the right of the existing copy activity.

    ![](Media/image0092.png)

3.  Select the Notebook activity on the design surface to display tabs containing its properties and settings at the bottom of the screen.

4.  In the General Tab enter “LabNotebook” into the Name field.

    ![](Media/image0097.png)

5.  In the Azure Databricks Tab Select +New next to Databricks Linked Service to create a new Linked Service

    ![](Media/image0096.png)

6.  Configure the New Linked Service.

-   **Name**: AzureDatabricks.

-   **Azure Subscription**: Azure Pass - Sponsorship

-   **Databricks workspace**: Select the workspace you are using for this lab.

-   **Select cluster**: Choose Existing interactive cluster.

-   **Access token**: Paste the token you generated in step one into this field.

-   **Existing cluster id**: Select the Databricks cluster you are using for this lab. *Note: if this drop down box does not populate, ensure that you copied your Access Token correctly into the Access token field.*

-   Select **Test connection** and ensure you get a Connection successful message.

-   Select **Create**.

> ![](Media/image0095.png)

Int the Settings Tab for Notebook, select Browse, and select the Databricks-Data-Transformations notebook from the /Users/*\[your-user-account\]/*03-Data-Ingestion-Via-ADF/includes/Databricks-Data-Transformations.

![](Media/image0105.png)

*Make sure you select the notebook in the includes folder selected. Students commonly select the notebook in the higher level folder and then they have errors or they only select the folder and not the notebook*

7.  Expand Base Parameters.

8.  Select +New.

9.  Enter "accountName" as the parameter Name, and the name of the Storage account you created into the Value.

10. Select +New under Base parameters and enter "accountKey" as the Name of the second parameter and paste in the Key for your storage account into the Value. The account key can be retrieved from the Access keys section in your Storage account:

    -   Select show keys and copy the value under Key 1

        ![](Media/image0137.png)

11. Select +New again, and enter "containerName" as the name of the third parameter and enter "dwtemp" for its Value.

    ![](Media/image0115.png)

<!-- -->

5.  Connect Copy Activity to Notebook Activity

    Select the small green box on the right-hand side of the copy activity and drag the arrow onto the Notebook activity on the design surface.  Creating this connection sets the output from the copy activity as required input for the Databricks Notebook activity. What this means is that the copy activity has to successfully complete processing and generate its files in your storage account before the Notebook activity runs, ensuring the files required by that Notebook activity are in place at the time of execution.

    ![](Media/image0114.png)

6.  Publish Pipeline

> In the ADF UI toolbar, if you have Git configured, select **Save all** to save your changes to your Git repo. Then select **Publish** to deploy your changes to the Azure Data Factory service.

![](Media/image0113.png)

7.  Trigger and Monitor the Pipeline Run

<!-- -->

1.  Trigger the pipeline by selecting Add trigger, then Trigger Now on your pipeline.

    ![](Media/image0117.png)

2.  Next, navigate to the Monitor screen by selecting the Monitor icon in the left-hand menu.

    ![](Media/image0116.png)

3.  Click the pipeline under Pipeline Name to see the progress of the active pipeline run. Here you can observe the ADF pipeline activities running. Notice the Databricks Notebook activity will not run until of the copy activity has completed. Once done, you will see a Succeeded message next to each activity.

    ![](Media/image0135.png)

    ![](Media/image0112.png)

4.  To view the notebook output of the run, you can select the Output Action next to the LabNotebook activity, and then select the runPageUrl value. This will open the executed notebook within Databricks, and you can view details of the run in each cell's output.

    ![](Media/image0108.png)

<!-- -->

8.  **Navigate back to Databricks**

    1.  Select the **02-Data-Transformation** Databricks Notebook from the 03-Data-Ingestion-Via-ADF Workspace

        ![](Media/image0100.png)

9.  Attach the notebook to a cluster before running any cells.

    ![](Media/image0107.png)

10. Continue with the instructions in the **02-Data-Transformation** notebook to **Verify transformations and aggregate the data** in the notebook

Exercise 4 has been completed.
