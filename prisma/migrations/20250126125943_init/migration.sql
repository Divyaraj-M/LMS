-- CreateTable
CREATE TABLE "Project" (
    "ProjectCode" TEXT NOT NULL,
    "NameOfTheCollege" TEXT NOT NULL,
    "CollegeCode" TEXT NOT NULL,
    "Year" TEXT NOT NULL,
    "CourseStream" TEXT NOT NULL,
    "DomainOfTraining" TEXT NOT NULL,
    "TypeOfProject" TEXT NOT NULL,
    "AcademicYear" TEXT NOT NULL,
    "Sales" TEXT NOT NULL,
    "MOUSignedDate" TIMESTAMP(3) NOT NULL,
    "TrainingStartDate" TIMESTAMP(3) NOT NULL,
    "TrainingEndDate" TIMESTAMP(3) NOT NULL,
    "NoOfStudents" INTEGER NOT NULL,
    "CostPerStudent" DOUBLE PRECISION NOT NULL,
    "TotalContractValue" DOUBLE PRECISION NOT NULL,
    "TotalContractValueInclGST" DOUBLE PRECISION NOT NULL,
    "HrsPerBatch" INTEGER NOT NULL,
    "TypeOfPayment" TEXT NOT NULL,
    "PaymentPercentage" DOUBLE PRECISION NOT NULL,
    "NoOfInvoices" INTEGER NOT NULL,

    CONSTRAINT "Project_pkey" PRIMARY KEY ("ProjectCode")
);

-- CreateTable
CREATE TABLE "Admin" (
    "adminId" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "org" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,

    CONSTRAINT "Admin_pkey" PRIMARY KEY ("adminId")
);

-- CreateTable
CREATE TABLE "Student" (
    "StudentID" TEXT NOT NULL,
    "StudentName" TEXT NOT NULL,
    "Email" TEXT NOT NULL,
    "Contact" TEXT NOT NULL,
    "Dept" TEXT NOT NULL,
    "ProjectCode" TEXT NOT NULL,
    "BatchID" TEXT NOT NULL,
    "TrainingHours" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "Student_pkey" PRIMARY KEY ("StudentID")
);

-- CreateTable
CREATE TABLE "Batch" (
    "BatchID" TEXT NOT NULL,
    "ProjectCode" TEXT NOT NULL,
    "BatchName" TEXT NOT NULL,
    "NoOfStudents" INTEGER NOT NULL,
    "TotalBatchHours" DOUBLE PRECISION NOT NULL,
    "StartDate" TIMESTAMP(3) NOT NULL,
    "EndDate" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Batch_pkey" PRIMARY KEY ("BatchID")
);

-- CreateTable
CREATE TABLE "BatchSchedule" (
    "ScheduleID" TEXT NOT NULL,
    "BatchID" TEXT NOT NULL,
    "TrainerID" TEXT NOT NULL,
    "Date" TIMESTAMP(3) NOT NULL,
    "StartTime" TIMESTAMP(3) NOT NULL,
    "EndTime" TIMESTAMP(3) NOT NULL,
    "TotalHours" DOUBLE PRECISION NOT NULL,
    "Topics" TEXT NOT NULL,

    CONSTRAINT "BatchSchedule_pkey" PRIMARY KEY ("ScheduleID")
);

-- CreateTable
CREATE TABLE "Trainer" (
    "TrainerID" TEXT NOT NULL,
    "TrainerName" TEXT NOT NULL,
    "Contact" TEXT NOT NULL,
    "Email" TEXT NOT NULL,
    "Specialization" TEXT NOT NULL,
    "NameOfAccountHolder" TEXT NOT NULL,
    "BankName" TEXT NOT NULL,
    "AccountNo" TEXT NOT NULL,
    "IFSCCode" TEXT NOT NULL,
    "PANCard" TEXT NOT NULL,
    "BankBranchAddress" TEXT NOT NULL,
    "AadharCard" TEXT NOT NULL,
    "YearsOfExperience" INTEGER NOT NULL,

    CONSTRAINT "Trainer_pkey" PRIMARY KEY ("TrainerID")
);

-- CreateTable
CREATE TABLE "TrainerAssignment" (
    "TrainerAssignmentID" TEXT NOT NULL,
    "TrainerID" TEXT NOT NULL,
    "ProjectCode" TEXT NOT NULL,
    "ScheduleID" TEXT NOT NULL,

    CONSTRAINT "TrainerAssignment_pkey" PRIMARY KEY ("TrainerAssignmentID")
);

-- CreateTable
CREATE TABLE "Invoice" (
    "SNo" SERIAL NOT NULL,
    "ProjectCode" TEXT NOT NULL,
    "InvoiceNo" TEXT NOT NULL,
    "PaymentType" TEXT NOT NULL,
    "TotalContractValue" DOUBLE PRECISION NOT NULL,
    "PaymentPercentage" DOUBLE PRECISION NOT NULL,
    "AmountFromMOU" DOUBLE PRECISION NOT NULL,
    "AmountRaised" DOUBLE PRECISION NOT NULL,
    "DateRaised" TIMESTAMP(3) NOT NULL,
    "InvoiceCode" TEXT NOT NULL,
    "InvoiceType" TEXT NOT NULL,
    "Status" TEXT NOT NULL,
    "Remarks" TEXT NOT NULL,
    "GAInvoiceCode" TEXT NOT NULL,

    CONSTRAINT "Invoice_pkey" PRIMARY KEY ("SNo")
);

-- CreateTable
CREATE TABLE "TrainerInvoiceData" (
    "InvoiceID" TEXT NOT NULL,
    "Date" TIMESTAMP(3) NOT NULL,
    "BillNo" TEXT NOT NULL,
    "ProjectCode" TEXT NOT NULL,
    "TrainerAssignmentID" TEXT NOT NULL,
    "TrainerID" TEXT NOT NULL,
    "TrainerName" TEXT NOT NULL,
    "Topic" TEXT NOT NULL,
    "Domain" TEXT NOT NULL,
    "FromDate" TIMESTAMP(3) NOT NULL,
    "ToDate" TIMESTAMP(3) NOT NULL,
    "NoOfHours" INTEGER NOT NULL,
    "NoOfStudents" INTEGER NOT NULL,
    "NoOfSessions" INTEGER NOT NULL,
    "NoOfDays" INTEGER NOT NULL,
    "ChargesPerHour" DOUBLE PRECISION NOT NULL,
    "Conveyance" DOUBLE PRECISION NOT NULL,
    "FoodAllowance" DOUBLE PRECISION NOT NULL,
    "Lodging" DOUBLE PRECISION NOT NULL,
    "TotalTrainingCharges" DOUBLE PRECISION NOT NULL,
    "TotalReimbursements" DOUBLE PRECISION NOT NULL,
    "TDSDeduction" DOUBLE PRECISION NOT NULL,
    "Total" DOUBLE PRECISION NOT NULL,
    "AdhocAdditionDeduction" DOUBLE PRECISION NOT NULL,
    "NetPayment" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "TrainerInvoiceData_pkey" PRIMARY KEY ("InvoiceID")
);

-- AddForeignKey
ALTER TABLE "Student" ADD CONSTRAINT "Student_ProjectCode_fkey" FOREIGN KEY ("ProjectCode") REFERENCES "Project"("ProjectCode") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Student" ADD CONSTRAINT "Student_BatchID_fkey" FOREIGN KEY ("BatchID") REFERENCES "Batch"("BatchID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Batch" ADD CONSTRAINT "Batch_ProjectCode_fkey" FOREIGN KEY ("ProjectCode") REFERENCES "Project"("ProjectCode") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BatchSchedule" ADD CONSTRAINT "BatchSchedule_BatchID_fkey" FOREIGN KEY ("BatchID") REFERENCES "Batch"("BatchID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BatchSchedule" ADD CONSTRAINT "BatchSchedule_TrainerID_fkey" FOREIGN KEY ("TrainerID") REFERENCES "Trainer"("TrainerID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TrainerAssignment" ADD CONSTRAINT "TrainerAssignment_TrainerID_fkey" FOREIGN KEY ("TrainerID") REFERENCES "Trainer"("TrainerID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TrainerAssignment" ADD CONSTRAINT "TrainerAssignment_ProjectCode_fkey" FOREIGN KEY ("ProjectCode") REFERENCES "Project"("ProjectCode") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TrainerAssignment" ADD CONSTRAINT "TrainerAssignment_ScheduleID_fkey" FOREIGN KEY ("ScheduleID") REFERENCES "BatchSchedule"("ScheduleID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invoice" ADD CONSTRAINT "Invoice_ProjectCode_fkey" FOREIGN KEY ("ProjectCode") REFERENCES "Project"("ProjectCode") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TrainerInvoiceData" ADD CONSTRAINT "TrainerInvoiceData_ProjectCode_fkey" FOREIGN KEY ("ProjectCode") REFERENCES "Project"("ProjectCode") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TrainerInvoiceData" ADD CONSTRAINT "TrainerInvoiceData_TrainerID_fkey" FOREIGN KEY ("TrainerID") REFERENCES "Trainer"("TrainerID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TrainerInvoiceData" ADD CONSTRAINT "TrainerInvoiceData_TrainerAssignmentID_fkey" FOREIGN KEY ("TrainerAssignmentID") REFERENCES "TrainerAssignment"("TrainerAssignmentID") ON DELETE RESTRICT ON UPDATE CASCADE;
