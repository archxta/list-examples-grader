CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

# Remove existing directories and files
rm -rf student-submission
rm -rf grading-area

# Create grading-area directory
mkdir grading-area

# Clone the student's repository
git clone $1 student-submission
echo 'Finished cloning'

# Check if ListExamples.java exists
if [ -f student-submission/ListExamples.java ]; then
    echo "File Exists"
else 
    echo "ListExamples.java does not exist"
    echo "Grade: 0"
    exit 1
fi

# Copy student's code and necessary libraries to grading-area
cp student-submission/ListExamples.java grading-area/TestListExamples.java
cp -r lib grading-area

# Compile the code
cd grading-area || exit
javac -cp $CPATH ListExamples.java TestListExamples.java

# Check if compilation was successful
if [ $? -ne 0 ]; then
    echo "Error: Compilation failed."
    exit 1
fi

# Run the tests
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples

echo "Grade: ?"  # You can add grading logic here based on test results
