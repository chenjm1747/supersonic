package com.tencent.supersonic.headless.chat.knowledge.helper;

import com.google.common.collect.Lists;
import com.hankcs.hanlp.HanLP;
import com.hankcs.hanlp.corpus.tag.Nature;
import com.hankcs.hanlp.dictionary.CoreDictionary;
import com.hankcs.hanlp.dictionary.DynamicCustomDictionary;
import com.hankcs.hanlp.seg.Segment;
import com.hankcs.hanlp.seg.common.Term;
import com.tencent.supersonic.common.pojo.enums.DictWordType;
import com.tencent.supersonic.headless.api.pojo.response.S2Term;
import com.tencent.supersonic.headless.chat.knowledge.DatabaseMapResult;
import com.tencent.supersonic.headless.chat.knowledge.DictWord;
import com.tencent.supersonic.headless.chat.knowledge.EmbeddingResult;
import com.tencent.supersonic.headless.chat.knowledge.HadoopFileIOAdapter;
import com.tencent.supersonic.headless.chat.knowledge.HanlpMapResult;
import com.tencent.supersonic.headless.chat.knowledge.MapResult;
import com.tencent.supersonic.headless.chat.knowledge.MultiCustomDictionary;
import com.tencent.supersonic.headless.chat.knowledge.SearchService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ResourceUtils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;

/** HanLP helper */
@Slf4j
public class HanlpHelper {

    public static final String FILE_SPILT = File.separator;
    public static final String SPACE_SPILT = "#";
    private static volatile DynamicCustomDictionary CustomDictionary;
    private static volatile Segment segment;

    static {
        // reset hanlp config
        try {
            resetHanlpConfig();
        } catch (FileNotFoundException e) {
            log.error("resetHanlpConfig error", e);
        }
    }

    public static Segment getSegment() {
        if (segment == null) {
            synchronized (HanlpHelper.class) {
                if (segment == null) {
                    segment = HanLP.newSegment().enableIndexMode(true).enableIndexMode(4)
                            .enableCustomDictionary(true).enableCustomDictionaryForcing(true)
                            .enableOffset(true).enableJapaneseNameRecognize(false)
                            .enableNameRecognize(false).enableAllNamedEntityRecognize(false)
                            .enableJapaneseNameRecognize(false)
                            .enableNumberQuantifierRecognize(false).enablePlaceRecognize(false)
                            .enableOrganizationRecognize(false)
                            .enableCustomDictionary(getDynamicCustomDictionary());
                }
            }
        }
        return segment;
    }

    public static DynamicCustomDictionary getDynamicCustomDictionary() {
        if (CustomDictionary == null) {
            synchronized (HanlpHelper.class) {
                if (CustomDictionary == null) {
                    CustomDictionary = new MultiCustomDictionary(HanLP.Config.CustomDictionaryPath);
                }
            }
        }
        return CustomDictionary;
    }

    /** reload custom dictionary */
    public static boolean reloadCustomDictionary() throws IOException {

        final long startTime = System.currentTimeMillis();

        if (HanLP.Config.CustomDictionaryPath == null
                || HanLP.Config.CustomDictionaryPath.length == 0) {
            return false;
        }
        if (HanLP.Config.IOAdapter instanceof HadoopFileIOAdapter) {
            // 1.delete hdfs file
            HdfsFileHelper.deleteCacheFile(HanLP.Config.CustomDictionaryPath);
            // 2.query txt files，update CustomDictionaryPath
            HdfsFileHelper.resetCustomPath(getDynamicCustomDictionary());
        } else {
            FileHelper.deleteCacheFile(HanLP.Config.CustomDictionaryPath);
            FileHelper.resetCustomPath(getDynamicCustomDictionary());
        }

        boolean reload = getDynamicCustomDictionary().reload();
        if (reload) {
            log.info("Custom dictionary has been reloaded in {} milliseconds",
                    System.currentTimeMillis() - startTime);
        }
        return reload;
    }

    private static void resetHanlpConfig() throws FileNotFoundException {
        if (HanLP.Config.IOAdapter instanceof HadoopFileIOAdapter) {
            return;
        }
        String hanlpPropertiesPath = getHanlpPropertiesPath();

        HanLP.Config.CustomDictionaryPath = Arrays.stream(HanLP.Config.CustomDictionaryPath)
                .map(path -> prependPathIfRelative(hanlpPropertiesPath, path))
                .toArray(String[]::new);
        log.info("hanlpPropertiesPath:{},CustomDictionaryPath:{}", hanlpPropertiesPath,
                HanLP.Config.CustomDictionaryPath);

        log.info("Original CoreDictionaryPath before override: {}",
                HanLP.Config.CoreDictionaryPath);

        // 直接设置所有词典路径为绝对路径，避免路径拼接问题
        String basePath =
                hanlpPropertiesPath != null ? hanlpPropertiesPath : "E:/trae/supersonic/data";
        HanLP.Config.CoreDictionaryPath = basePath + "/dictionary/CoreNatureDictionary.mini.txt";
        HanLP.Config.CoreDictionaryTransformMatrixDictionaryPath =
                basePath + "/dictionary/CoreNatureDictionary.transform.matrix.bin";
        HanLP.Config.BiGramDictionaryPath =
                basePath + "/dictionary/CoreNatureDictionary.ngram.mini.txt";
        HanLP.Config.CoreStopWordDictionaryPath = basePath + "/dictionary/stopwords.txt";
        HanLP.Config.CoreSynonymDictionaryDictionaryPath =
                basePath + "/dictionary/synonym/SynonymDictionary.txt";
        HanLP.Config.PersonDictionaryPath = basePath + "/dictionary/person/nr.txt";
        HanLP.Config.PersonDictionaryTrPath = basePath + "/dictionary/person/nr.tr.txt";
        HanLP.Config.TranslatedPersonDictionaryPath =
                basePath + "/dictionary/translate/TranslatedPerson.txt";
        HanLP.Config.JapanesePersonDictionaryPath =
                basePath + "/dictionary/japan/japanese_names.drc";
        HanLP.Config.PlaceDictionaryPath = basePath + "/dictionary/place/ns.txt";
        HanLP.Config.PlaceDictionaryTrPath = basePath + "/dictionary/place/ns.tr.txt";
        HanLP.Config.OrganizationDictionaryPath = basePath + "/dictionary/organization/nt.txt";
        HanLP.Config.OrganizationDictionaryTrPath = basePath + "/dictionary/organization/nt.tr.txt";
        HanLP.Config.CharTypePath = basePath + "/dictionary/other/CharType.bin";
        HanLP.Config.CharTablePath = basePath + "/dictionary/other/CharTable.bin";
        HanLP.Config.PartOfSpeechTagDictionary =
                basePath + "/dictionary/core/PartOfSpeechTagging.txt";
        HanLP.Config.WordNatureModelPath = basePath + "/model/pos/CRFModel.txt";
        HanLP.Config.MaxEntModelPath = basePath + "/model/ner/ner.maxent";
        HanLP.Config.NNParserModelPath = basePath + "/model/dependency_parser/nn_parser_model.txt";
        HanLP.Config.PerceptronParserModelPath =
                basePath + "/model/dependency_parser/parser_model.bin";
        HanLP.Config.CRFSegmentModelPath = basePath + "/model/segment/CRFSegmentModel.txt";
        HanLP.Config.HMMSegmentModelPath = basePath + "/model/segment/HMMSegmentModel.bin";
        HanLP.Config.CRFPOSModelPath = basePath + "/model/pos/CRFPOSModel.txt";
        HanLP.Config.CRFNERModelPath = basePath + "/model/ner/CRFNERModel.txt";
        HanLP.Config.PerceptronCWSModelPath = basePath + "/model/segment/PerceptronCWSModel.txt";
        HanLP.Config.PerceptronPOSModelPath = basePath + "/model/pos/PerceptronPOSModel.txt";
        HanLP.Config.PerceptronNERModelPath = basePath + "/model/ner/PerceptronNERModel.txt";

        log.info("Setting CoreDictionaryPath to: {}", HanLP.Config.CoreDictionaryPath);
        HanLP.Config.CoreDictionaryTransformMatrixDictionaryPath = prependPathIfRelative(
                hanlpPropertiesPath, HanLP.Config.CoreDictionaryTransformMatrixDictionaryPath);
        if (HanLP.Config.BiGramDictionaryPath != null
                && !HanLP.Config.BiGramDictionaryPath.isEmpty()) {
            String originalPath = HanLP.Config.BiGramDictionaryPath;
            HanLP.Config.BiGramDictionaryPath =
                    prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.BiGramDictionaryPath);
            log.info("BiGramDictionaryPath updated: {} -> {}", originalPath,
                    HanLP.Config.BiGramDictionaryPath);
            // 验证文件是否存在
            File bigramFile = new File(HanLP.Config.BiGramDictionaryPath);
            log.info("BiGramDictionary file exists: {}, canRead: {}", bigramFile.exists(),
                    bigramFile.canRead());
        }
        HanLP.Config.CoreStopWordDictionaryPath =
                prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.CoreStopWordDictionaryPath);
        HanLP.Config.CoreSynonymDictionaryDictionaryPath = prependPathIfRelative(
                hanlpPropertiesPath, HanLP.Config.CoreSynonymDictionaryDictionaryPath);
        HanLP.Config.PersonDictionaryPath =
                prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.PersonDictionaryPath);
        HanLP.Config.PersonDictionaryTrPath =
                prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.PersonDictionaryTrPath);

        HanLP.Config.PinyinDictionaryPath =
                prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.PinyinDictionaryPath);
        HanLP.Config.TranslatedPersonDictionaryPath = prependPathIfRelative(hanlpPropertiesPath,
                HanLP.Config.TranslatedPersonDictionaryPath);
        HanLP.Config.JapanesePersonDictionaryPath = prependPathIfRelative(hanlpPropertiesPath,
                HanLP.Config.JapanesePersonDictionaryPath);
        HanLP.Config.PlaceDictionaryPath =
                prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.PlaceDictionaryPath);
        HanLP.Config.PlaceDictionaryTrPath =
                prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.PlaceDictionaryTrPath);
        HanLP.Config.OrganizationDictionaryPath =
                prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.OrganizationDictionaryPath);
        HanLP.Config.OrganizationDictionaryTrPath = prependPathIfRelative(hanlpPropertiesPath,
                HanLP.Config.OrganizationDictionaryTrPath);
        HanLP.Config.CharTypePath =
                prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.CharTypePath);
        HanLP.Config.CharTablePath =
                prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.CharTablePath);
        HanLP.Config.PartOfSpeechTagDictionary =
                prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.PartOfSpeechTagDictionary);
        HanLP.Config.WordNatureModelPath =
                prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.WordNatureModelPath);
        HanLP.Config.MaxEntModelPath =
                prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.MaxEntModelPath);
        HanLP.Config.NNParserModelPath =
                prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.NNParserModelPath);
        HanLP.Config.PerceptronParserModelPath =
                prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.PerceptronParserModelPath);
        HanLP.Config.CRFSegmentModelPath =
                prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.CRFSegmentModelPath);
        HanLP.Config.HMMSegmentModelPath =
                prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.HMMSegmentModelPath);
        HanLP.Config.CRFCWSModelPath =
                prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.CRFCWSModelPath);
        HanLP.Config.CRFPOSModelPath =
                prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.CRFPOSModelPath);
        HanLP.Config.CRFNERModelPath =
                prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.CRFNERModelPath);
        HanLP.Config.PerceptronCWSModelPath =
                prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.PerceptronCWSModelPath);
        HanLP.Config.PerceptronPOSModelPath =
                prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.PerceptronPOSModelPath);
        HanLP.Config.PerceptronNERModelPath =
                prependPathIfRelative(hanlpPropertiesPath, HanLP.Config.PerceptronNERModelPath);

        // 强制初始化HanLP，确保配置生效
        try {
            log.info("Forcing HanLP initialization with corrected paths...");
            // 执行一个简单的分词来触发HanLP初始化
            Segment segment = HanLP.newSegment();
            segment.seg("测试");
            log.info("HanLP initialization successful!");
        } catch (Exception e) {
            log.error("HanLP initialization failed after reset! Path: {}",
                    HanLP.Config.CoreDictionaryPath, e);
        }
    }

    private static String prependPathIfRelative(String basePath, String relativePath) {
        if (relativePath == null) {
            return null;
        }
        File file = new File(relativePath);
        if (file.isAbsolute()) {
            return relativePath;
        }
        return basePath + FILE_SPILT + relativePath;
    }

    public static String getHanlpPropertiesPath() throws FileNotFoundException {
        // 首先尝试加载外部配置文件
        String defaultPath = "E:/trae/supersonic/data";
        String externalPropertiesPath = defaultPath + "/hanlp.properties";

        File externalFile = new File(externalPropertiesPath);
        if (externalFile.exists()) {
            // 检查配置是否为空或只有注释
            try (BufferedReader reader = new BufferedReader(new FileReader(externalFile))) {
                String line;
                boolean hasConfig = false;
                while ((line = reader.readLine()) != null) {
                    line = line.trim();
                    if (!line.isEmpty() && !line.startsWith("#")) {
                        hasConfig = true;
                        break;
                    }
                }
                if (hasConfig) {
                    log.info("Loading hanlp.properties from external path: {}",
                            externalPropertiesPath);
                    String configRoot = loadRootFromProperties(externalFile);
                    if (configRoot != null) {
                        log.info("Using root from hanlp.properties: {}", configRoot);
                        return configRoot;
                    }
                } else {
                    log.info(
                            "External hanlp.properties is empty or only contains comments, using jar internal dictionaries");
                }
            } catch (IOException e) {
                log.warn("Failed to read hanlp.properties: {}", e.getMessage());
            }
        }

        // 如果外部配置为空或不存在，返回null，让HanLP使用jar内部的默认词典
        log.info("Using HanLP jar internal dictionaries");
        return null;
    }

    private static String loadRootFromProperties(File propertiesFile) {
        try (BufferedReader reader = new BufferedReader(new FileReader(propertiesFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                // Skip comments and empty lines
                if (line.isEmpty() || line.startsWith("#")) {
                    continue;
                }
                // Check for CoreDictionaryPath - if it's already an absolute path, return it
                // directly
                if (line.startsWith("CoreDictionaryPath=")) {
                    String value = line.substring("CoreDictionaryPath=".length()).trim();
                    if (value.matches("^[A-Za-z]:.*") || value.startsWith("/")) {
                        // It's already an absolute path (Windows: C:\..., Linux/Mac: /...)
                        log.info("Found absolute CoreDictionaryPath in hanlp.properties: {}",
                                value);
                        return value;
                    }
                }
                // Check for root configuration
                if (line.startsWith("root=")) {
                    String root = line.substring(5).trim();
                    log.info("Found root configuration in hanlp.properties: {}", root);
                    return root;
                }
            }
        } catch (IOException e) {
            log.warn("Failed to read root from hanlp.properties: {}", e.getMessage());
        }
        return null;
    }

    public static boolean addToCustomDictionary(DictWord dictWord) {
        log.debug("dictWord:{}", dictWord);
        return getDynamicCustomDictionary().insert(dictWord.getWord(),
                dictWord.getNatureWithFrequency());
    }

    public static void removeFromCustomDictionary(DictWord dictWord) {
        log.debug("dictWord:{}", dictWord);
        CoreDictionary.Attribute attribute = getDynamicCustomDictionary().get(dictWord.getWord());
        if (attribute == null) {
            return;
        }
        log.info("get attribute:{}", attribute);
        getDynamicCustomDictionary().remove(dictWord.getWord());
        StringBuilder sb = new StringBuilder();
        List<Nature> natureList = new ArrayList<>();
        for (int i = 0; i < attribute.nature.length; i++) {
            if (!attribute.nature[i].toString().equals(dictWord.getNature())) {
                sb.append(attribute.nature[i].toString() + " ");
                sb.append(attribute.frequency[i] + " ");
                natureList.add((attribute.nature[i]));
            }
        }
        String natureWithFrequency = sb.toString();
        int len = natureWithFrequency.length();
        log.info("filtered natureWithFrequency:{}", natureWithFrequency);
        if (StringUtils.isNotBlank(natureWithFrequency)) {
            getDynamicCustomDictionary().add(dictWord.getWord(),
                    natureWithFrequency.substring(0, len - 1));
        }
        SearchService.remove(dictWord, natureList.toArray(new Nature[0]));
    }

    public static <T extends MapResult> void transLetterOriginal(List<T> mapResults) {
        if (CollectionUtils.isEmpty(mapResults)) {
            return;
        }

        List<T> newResults = new ArrayList<>();

        for (T mapResult : mapResults) {
            String name = mapResult.getName();
            boolean isAdded = false;
            if (MultiCustomDictionary.isLowerLetter(name) && CustomDictionary.contains(name)) {
                CoreDictionary.Attribute attribute = CustomDictionary.get(name);
                if (attribute != null) {
                    isAdded = addLetterOriginal(newResults, mapResult, attribute);
                }
            }

            if (!isAdded) {
                newResults.add(mapResult);
            }
        }
        mapResults.clear();
        mapResults.addAll(newResults);
    }

    public static <T extends MapResult> boolean addLetterOriginal(List<T> mapResults, T mapResult,
            CoreDictionary.Attribute attribute) {
        if (attribute == null) {
            return false;
        }
        boolean isAdd = false;
        if (mapResult instanceof HanlpMapResult) {
            HanlpMapResult hanlpMapResult = (HanlpMapResult) mapResult;
            for (String nature : hanlpMapResult.getNatures()) {
                String orig = attribute.getOriginal(Nature.fromString(nature));
                if (orig != null) {
                    MapResult addMapResult = new HanlpMapResult(orig, Arrays.asList(nature),
                            hanlpMapResult.getDetectWord(), hanlpMapResult.getSimilarity());
                    mapResults.add((T) addMapResult);
                    isAdd = true;
                }
            }
            return isAdd;
        }

        List<String> originals = attribute.getOriginals();
        if (CollectionUtils.isEmpty(originals)) {
            return false;
        }

        if (mapResult instanceof DatabaseMapResult) {
            DatabaseMapResult dbMapResult = (DatabaseMapResult) mapResult;
            for (String orig : originals) {
                DatabaseMapResult addMapResult = new DatabaseMapResult();
                addMapResult.setName(orig);
                addMapResult.setSchemaElement(dbMapResult.getSchemaElement());
                addMapResult.setDetectWord(dbMapResult.getDetectWord());
                mapResults.add((T) addMapResult);
                isAdd = true;
            }
        } else if (mapResult instanceof EmbeddingResult) {
            EmbeddingResult embeddingResult = (EmbeddingResult) mapResult;
            for (String orig : originals) {
                EmbeddingResult addMapResult = new EmbeddingResult();
                addMapResult.setName(orig);
                addMapResult.setDetectWord(embeddingResult.getDetectWord());
                addMapResult.setId(embeddingResult.getId());
                addMapResult.setMetadata(embeddingResult.getMetadata());
                addMapResult.setSimilarity(embeddingResult.getSimilarity());
                mapResults.add((T) addMapResult);
                isAdd = true;
            }
        }

        return isAdd;
    }

    public static List<S2Term> getTerms(String text, Map<Long, List<Long>> modelIdToDataSetIds) {
        return getSegment().seg(text.toLowerCase()).stream()
                .filter(term -> term.getNature().startsWith(DictWordType.NATURE_SPILT))
                .map(term -> transform2ApiTerm(term, modelIdToDataSetIds))
                .flatMap(Collection::stream).collect(Collectors.toList());
    }

    public static List<S2Term> getTerms(List<S2Term> terms, Set<Long> dataSetIds) {
        logTerms(terms);
        if (!CollectionUtils.isEmpty(dataSetIds)) {
            terms = terms.stream().filter(term -> {
                Long dataSetId = NatureHelper.getDataSetId(term.getNature().toString());
                if (Objects.nonNull(dataSetId)) {
                    return dataSetIds.contains(dataSetId);
                }
                return false;
            }).collect(Collectors.toList());
            log.debug("terms filter by dataSetId:{}", dataSetIds);
            logTerms(terms);
        }
        return terms;
    }

    public static List<S2Term> transform2ApiTerm(Term term,
            Map<Long, List<Long>> modelIdToDataSetIds) {
        List<S2Term> s2Terms = Lists.newArrayList();
        List<String> natures = NatureHelper.changeModel2DataSet(String.valueOf(term.getNature()),
                modelIdToDataSetIds);
        for (String nature : natures) {
            S2Term s2Term = new S2Term();
            BeanUtils.copyProperties(term, s2Term);
            s2Term.setNature(Nature.create(nature));
            s2Term.setFrequency(term.getFrequency());
            s2Terms.add(s2Term);
        }
        return s2Terms;
    }

    private static void logTerms(List<S2Term> terms) {
        if (CollectionUtils.isEmpty(terms)) {
            return;
        }
        for (S2Term term : terms) {
            log.debug("word:{},nature:{},frequency:{}", term.word, term.nature.toString(),
                    term.getFrequency());
        }
    }
}
