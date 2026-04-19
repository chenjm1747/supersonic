package com.tencent.supersonic.headless.core.text2sql.utils;

import com.tencent.supersonic.headless.core.text2sql.dto.ColumnSchema;
import com.tencent.supersonic.headless.core.text2sql.dto.TableSchema;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Component
public class SqlFileParser {
    private static final Logger log = LoggerFactory.getLogger(SqlFileParser.class);

    public List<TableSchema> parse(String filePath) throws IOException {
        String content =
                Files.readString(Path.of(filePath), java.nio.charset.StandardCharsets.UTF_8);
        List<TableSchema> tables = new ArrayList<>();

        Pattern createTablePattern =
                Pattern.compile("CREATE TABLE[^`]*`(\\w+)`[^;]*?\\(([\\s\\S]*?)\\)\\s*ENGINE",
                        Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);

        Matcher matcher = createTablePattern.matcher(content);
        while (matcher.find()) {
            String tableName = matcher.group(1);
            String columnsBlock = matcher.group(2);

            TableSchema table = new TableSchema();
            table.setTableName(tableName);
            table.setColumns(parseColumns(columnsBlock));
            tables.add(table);

            log.debug("Parsed table: {}, columns: {}", tableName, table.getColumns().size());
        }

        return tables;
    }

    private List<ColumnSchema> parseColumns(String block) {
        List<ColumnSchema> columns = new ArrayList<>();
        String[] lines = block.split("\n");

        Pattern colPattern = Pattern.compile(
                "`?(\\w+)`?\\s+([\\w]+(?:\\([^)]+\\))?(?:\\s+UNSIGNED|SIGNED)?(?:\\s+NOT\\s+NULL)?(?:\\s+DEFAULT\\s+[^,]+)?(?:\\s+AUTO_INCREMENT)?(?:\\s+COMMENT\\s+'[^']+')?",
                Pattern.CASE_INSENSITIVE);

        for (String line : lines) {
            line = line.trim();
            if (line.isEmpty() || line.startsWith("PRIMARY KEY") || line.startsWith("INDEX")
                    || line.startsWith("KEY ") || line.startsWith("UNIQUE")
                    || line.startsWith("CONSTRAINT") || line.startsWith("FOREIGN")
                    || line.startsWith("--") || line.startsWith("FULLTEXT")
                    || line.startsWith("COMMENT")) {
                continue;
            }

            line = line.replaceAll(",\\s*$", "").trim();
            if (line.isEmpty()) {
                continue;
            }

            Matcher matcher = colPattern.matcher(line);
            if (matcher.find()) {
                ColumnSchema column = new ColumnSchema();
                column.setColumnName(matcher.group(1));
                column.setColumnType(matcher.group(2));
                column.setColumnComment(matcher.group(3));
                column.setIsPrimaryKey(line.contains("PRIMARY KEY"));
                columns.add(column);
            }
        }

        return columns;
    }
}
