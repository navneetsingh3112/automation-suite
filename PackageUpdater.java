package in.novopay.accounting;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PackageUpdater {
    public static void main(String[] args) {

        String packageFilePath = "/home/navaneet/office/workspace/git_workspace/perf/novopay-platform-accounting-v2/package.txt";
        String resultJsonFilePath = "/home/navaneet/office/workspace/git_workspace/perf/novopay-platform-accounting-v2/result.json";

        try {
            // Read the result.json file
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode rootNode = objectMapper.readTree(new File(resultJsonFilePath));
            JsonNode packagesNode = rootNode.path("Packages");

            // Create a map to store package Id and NewestVersion
            Map<String, String> packageMap = new HashMap<>();
            for (JsonNode packageNode : packagesNode) {
                String packageId = packageNode.path("Id").asText();
                boolean isOutdated = packageNode.path("Outdated").asBoolean();
                if (isOutdated) {
                    String newestVersion = packageNode.path("NewestVersion").asText();
                    packageMap.put(packageId, newestVersion);
                }
            }

            // Read the package.txt file
            List<String> lines = Files.readAllLines(Paths.get(packageFilePath));
            for (String line : lines) {
                if (line.startsWith("implementation")) {
                    String[] parts = line.split("'");
                    if (parts.length > 1) {
                        String dependency = parts[1];
                        int lastColonIndex = dependency.lastIndexOf(":");
                        String packageId = "Maven-" + dependency.substring(0, lastColonIndex) + "-" + dependency.substring(lastColonIndex + 1);
                        if (packageMap.containsKey(packageId)) {
                            String newestVersion = packageMap.get(packageId);
                            String updatedDependency = dependency.substring(0, dependency.lastIndexOf(':') + 1) + newestVersion;
                            System.out.println("implementation '" + updatedDependency + "'");
                        } else {
                            System.out.println(line);
                        }
                    } else {
                        System.out.println(line);
                    }
                } else {
                    System.out.println(line);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
