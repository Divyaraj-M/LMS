import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function main() {
  try {
    // Admin sample data
    await prisma.admin.createMany({
        data: [
          {
            adminId: "admin123",  // Ensure this adminId is unique
            username: "admin_user",
            org: "Gryphon Academy",
            email: "admin@gryphonacademy.com",
            password: "securepassword123",
          },
        ],
      });

    // Check if the Project already exists
    const existingProject = await prisma.project.findUnique({
      where: { ProjectCode: "PRJ001" }, // Check for unique constraint violation
    });

    if (!existingProject) {
      // Project sample data - Only insert if it doesn't already exist
      await prisma.project.create({
        data: {
          ProjectCode: "PRJ001", // Ensure this is unique
          NameOfTheCollege: "ABC College",
          CollegeCode: "ABC123",
          Year: "2025",
          CourseStream: "Engineering",
          DomainOfTraining: "Data Science",
          TypeOfProject: "Corporate Training",
          AcademicYear: "2024-2025",
          Sales: "1000000",
          MOUSignedDate: new Date("2024-05-01"),
          TrainingStartDate: new Date("2024-06-01"),
          TrainingEndDate: new Date("2024-08-01"),
          NoOfStudents: 50,
          CostPerStudent: 2000,
          TotalContractValue: 100000,
          TotalContractValueInclGST: 118000,
          HrsPerBatch: 40,
          TypeOfPayment: "Installments",
          PaymentPercentage: 50,
          NoOfInvoices: 2,
        },
      });
    } else {
      console.log("Project with ProjectCode 'PRJ001' already exists. Skipping project creation.");
    }

    // Batch sample data
    await prisma.batch.create({
      data: {
        BatchID: "B001",
        ProjectCode: "PRJ001", // Ensure this references the correct ProjectCode
        BatchName: "Batch 1",
        NoOfStudents: 50,
        TotalBatchHours: 40,
        StartDate: new Date("2024-06-01"),
        EndDate: new Date("2024-07-01"),
      },
    });

    // Trainer sample data
    await prisma.trainer.create({
      data: {
        TrainerID: "T001",
        TrainerName: "Dr. Smith",
        Contact: "1234567890",
        Email: "trainer.smith@gmail.com",
        Specialization: "Data Science",
        NameOfAccountHolder: "Dr. Smith",
        BankName: "XYZ Bank",
        AccountNo: "123456789012",
        IFSCCode: "XYZ0001234",
        PANCard: "ABCDE1234F",
        BankBranchAddress: "123 Main St",
        AadharCard: "123456789012",
        YearsOfExperience: 10,
      },
    });

    // BatchSchedule sample data
    await prisma.batchSchedule.create({
      data: {
        ScheduleID: "S001",
        BatchID: "B001",
        TrainerID: "T001",
        Date: new Date("2024-06-10"),
        StartTime: new Date("2024-06-10T09:00:00Z"),
        EndTime: new Date("2024-06-10T13:00:00Z"),
        TotalHours: 4,
        Topics: "Introduction to Data Science",
      },
    });

    // Student sample data
    await prisma.student.createMany({
      data: [
        {
          StudentID: "ST001",
          StudentName: "John Doe",
          Email: "john.doe@gmail.com",
          Contact: "1234567890",
          Dept: "CSE",
          ProjectCode: "PRJ001",
          BatchID: "B001",
          TrainingHours: 40,
        },
        {
          StudentID: "ST002",
          StudentName: "Jane Smith",
          Email: "jane.smith@gmail.com",
          Contact: "0987654321",
          Dept: "CSE",
          ProjectCode: "PRJ001",
          BatchID: "B001",
          TrainingHours: 40,
        },
      ],
    });

    // TrainerAssignment sample data
    await prisma.trainerAssignment.create({
      data: {
        TrainerAssignmentID: "TA001",
        TrainerID: "T001",
        ProjectCode: "PRJ001",
        ScheduleID: "S001",
      },
    });

    // Invoice sample data
    await prisma.invoice.create({
      data: {
        SNo: 1,
        ProjectCode: "PRJ001",
        InvoiceNo: "INV001",
        PaymentType: "Installment",
        TotalContractValue: 100000,
        PaymentPercentage: 50,
        AmountFromMOU: 50000,
        AmountRaised: 50000,
        DateRaised: new Date("2024-05-15"),
        InvoiceCode: "IC001",
        InvoiceType: "Advance",
        Status: "Paid",
        Remarks: "First installment",
        GAInvoiceCode: "GA001",
      },
    });

    // TrainerInvoiceData sample data
    await prisma.trainerInvoiceData.create({
      data: {
        InvoiceID: "TI001",
        Date: new Date("2024-07-01"),
        BillNo: "B001",
        ProjectCode: "PRJ001",
        TrainerAssignmentID: "TA001",
        TrainerID: "T001",
        TrainerName: "Dr. Smith",
        Topic: "Data Science",
        Domain: "Data Science",
        FromDate: new Date("2024-06-01"),
        ToDate: new Date("2024-07-01"),
        NoOfHours: 40,
        NoOfStudents: 50,
        NoOfSessions: 10,
        NoOfDays: 10,
        ChargesPerHour: 1000,
        Conveyance: 2000,
        FoodAllowance: 3000,
        Lodging: 5000,
        TotalTrainingCharges: 40000,
        TotalReimbursements: 10000,
        TDSDeduction: 2000,
        Total: 48000,
        AdhocAdditionDeduction: 0,
        NetPayment: 48000,
      },
    });

    console.log("Sample data inserted successfully!");
  } catch (error) {
    console.error("Error seeding data:", error);
    process.exit(1);
  } finally {
    await prisma.$disconnect();
  }
}

main();
