import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import org.springframework.data.jpa.repository.Query;

public class RepositoryQueryScanner {

    public List<String> scanForQueries(String baseDir) {
        List<String> queries = new ArrayList<>();
        File baseDirectory = new File(baseDir);
        if (baseDirectory.exists() && baseDirectory.isDirectory()) {
            scanDirectory(baseDirectory, queries);
        }
        return queries;
    }

    private void scanDirectory(File directory, List<String> queries) {
        File[] files = directory.listFiles();
        if (files != null) {
            for (File file : files) {
                if (file.isDirectory()) {
                    scanDirectory(file, queries);
                } else if (file.getName().contains("Repository") && file.getName().endsWith(".java")) {
                    extractQueriesFromFile(file, queries);
                }
            }
        }
    }

    private void extractQueriesFromFile(File file, List<String> queries) {
        try {
            String className = file.getPath()
                    .replace("/home/navaneet/office/workspace/git_workspace/fork/novopay-platform-accounting-v2/src/main/java/", "")
                    .replace(".java", "")
                    .replace(File.separator, ".");
            Class<?> clazz = Class.forName(className);
            Method[] methods = clazz.getDeclaredMethods();
            for (Method method : methods) {
                Query queryAnnotation = method.getAnnotation(Query.class);
                if (queryAnnotation != null) {
                    queries.add(file.getName() + "~" + queryAnnotation.value());
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        RepositoryQueryScanner scanner = new RepositoryQueryScanner();
        List<String> queries = scanner.scanForQueries("/home/navaneet/office/workspace/git_workspace/fork/novopay-platform-accounting-v2/src/main/java/in/novopay/accounting");

        try (FileWriter writer = new FileWriter("queries_output.txt")) {
            for (String query : queries) {
                writer.write(query + System.lineSeparator());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
